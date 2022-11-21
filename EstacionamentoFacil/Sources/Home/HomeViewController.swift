//
//  HomeViewController.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 02/11/22.
//

import UIKit
import FirebaseAuth

final class HomeViewController: CoordinatedViewController {

    // MARK: - Private properties
    private let viewModel: HomeViewModelProtocol
    private var parkingSpaces: [ParkingSpace] = []
    private var clients: [ClientModel] = []
    
    private lazy var rootView = HomeViewV2(
        didTapButton: { [weak self] parkingSpace in
            self?.didTapParkingSpace(parkingSpace)
        },
        didTapCrateParkingSpace: {
            self.viewModel
                .navigateToRegisterNewParkingSpace(self.parkingSpaces)
        }
    )

    // MARK: - Init
    init(viewModel: HomeViewModelProtocol, coordinator: CoordinatorProtocol) {
        self.viewModel = viewModel
        super.init(coordinator: coordinator)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.shouldDisplayEmptyView(self.parkingSpaces.isEmpty)
        setupNavigationBar()
        viewModel.input.viewDidLoad()
        bindProperties()
    }
    
    func convertStringToDate(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy HH:mm")
        guard let date = dateFormatter.date(from: date) else { return .distantFuture }
        return date
    }
    
    func setTimeIntervalBetweenDates(date: String) -> String {
        let dateFormatted = convertStringToDate(date: date)
        let dateFormatter = DateFormatter()

        guard let date2 = DateComponents(
            calendar: .current,
            year: dateFormatted.get(.year),
            month: dateFormatted.get(.month),
            day: dateFormatted.get(.day),
            hour: dateFormatted.get(.hour),
            minute: dateFormatted.get(.minute)
        ).date else { return ""}

        let currentDate = Date()
        guard let currentDate2 = DateComponents(
            calendar: .current,
            year: currentDate.get(.year),
            month: currentDate.get(.month),
            day: currentDate.get(.day),
            hour: currentDate.get(.hour),
            minute: currentDate.get(.minute)
        ).date else { return ""}

        let timeOffset = currentDate2.offset(from: date2)
     
        return timeOffset
    }
    
    override func loadView() {
        super.loadView()
        view = rootView
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.input.viewDidLoad()
        bindProperties()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.setHidesBackButton(false, animated: true)
    }

    // MARK: - Private methods
    private func bindProperties() {
        viewModel.output.clients.bind() { [weak self] result in
            self?.clients = result
        }
        
        viewModel.output.parkingSpaces.bind() { [weak self] result in
            let sortedValues = result.sorted { (value1, value2) in
                let order = value1.numSpace.compare(value2.numSpace, options: .numeric)
                return order == .orderedAscending
            }
            self?.parkingSpaces = sortedValues
            self?.rootView.parkingSpaces = sortedValues
            self?.rootView.shouldDisplayEmptyView(sortedValues.isEmpty)
        }
            
    }

    private func didTapParkingSpace(_ parkingSpace: ParkingSpace) {
        
        if parkingSpace.statusSpace == .busy {
            self.showAlertToBusyParkingSpace(parkingSpace)
        }
        
        if parkingSpace.statusSpace == .inMaintenance {
            self.showAlertToInMaintenanceParkingSpace(parkingSpace)
        }
        
        self.viewModel.didTapParkingSpace(parkingSpace: parkingSpace)
    }
    
    private func emptyParkingSpace(_ parkingSpace: ParkingSpace) {
        let email = Current.shared.email
        let emptyParkingSpace = ParkingSpace(
            _id: parkingSpace._id,
            numSpace: parkingSpace.numSpace,
            statusSpace: .free,
            cpfClient: "",
            emailFirebase: email,
            firstDate: ""
        )
        self.viewModel.occupyParkingSpace(
            parkingSpace: emptyParkingSpace,
            id: parkingSpace._id) { [weak self] success in
                self?.viewDidLoad()
            }
    }

    private func showAlertToBusyParkingSpace(_ parkingSpace: ParkingSpace) {
        guard let client = clients.first(where: { $0.cpfClient ==  parkingSpace.cpfClient }) else { return }
        self.showAlertTwoActions(
            title: "Vaga nº \(parkingSpace.numSpace) ocupada!",
            message: self.setAlertOccupyMessage(client: client, parkingSpace: parkingSpace),
            leftLabels: true
        ) { self.emptyParkingSpace(parkingSpace) }
    }
    
    private func setAmount(min: String, prices: Prices) -> Int {
        guard let min = Int(min) else { return 0}
        if min <= 15 { return prices.fifteenMinutes }
        if min > 15 && min <= 30 { return prices.thirtyMinutes }
        if min > 30 && min <= 60 { return prices.hour }
        if min > 60 && min <= 120 { return prices.hour * 2 }
        if min > 120 && min <= 240 { return prices.hour * 3 }
        if min > 60 && min <= 1440 { return prices.daily }
        return 0
    }

    private func showAlertToInMaintenanceParkingSpace(_ parkingSpace: ParkingSpace) {
        self.showAlertTwoActions(
            title: "Vaga nº \(parkingSpace.numSpace) em manutenção!",
            message: "Deseja liberar a vaga?",
            leftButtonTitle: "Cancelar"
        ) { self.emptyParkingSpace(parkingSpace) }
    }

    private func setupNavigationBar() {
        title = "Estacionamento Fácil"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapRegisterNewParkingSpace)
        )
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(exit)
        )
        navigationController?.navigationBar.isHidden = false
    }

    @objc
    func didTapRegisterNewParkingSpace() {
        self.viewModel
            .navigateToRegisterNewParkingSpace(self.parkingSpaces)
    }

    @objc
    func exit() {
        viewModel.signOut { [weak self] result in
            result
            ? self?.showAlertTwoActions(
                title: "Tem certeza que deseja sair da conta?",
                leftButtonTitle: "Cancelar",
                rightButtonTitle: "Sair"
            ) {
                self?.viewModel.logout()
            }
            : self?.showAlert(
                title: "Ocorreu um erro",
                message: "Tente novamente."
            )
        }
    }
    
    private func setAlertOccupyMessage(client: ClientModel, parkingSpace: ParkingSpace) -> String {
        let interval = setTimeIntervalBetweenDates(date: parkingSpace.firstDate)
        let amount = setAmount(
            min: interval,
            prices: Prices(
                hour: 50,
                fifteenMinutes: 10,
                thirtyMinutes: 30,
                daily: 80
            )
        )
        
        let timeInverval = interval == "" ? "0" : interval
        return "\n• Cliente: \(client.clientName)\n• CPF: \(client.cpfClient)\n• Placa: \(client.plate)\n• Veículo: \(client.model)\n \n• Tempo ocupado: \(timeInverval) min\n• Total à pagar: R$ \(amount),00"
    }
}

struct Prices {
    let hour: Int
    let fifteenMinutes: Int
    let thirtyMinutes: Int
    let daily: Int
}
