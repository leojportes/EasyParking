//
//  HomeViewController.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 02/11/22.
//

import UIKit
import FirebaseAuth

class HomeViewController: CoordinatedViewController {

    // MARK: - Private properties
    private let viewModel: HomeViewModelProtocol
    private var didTapButton: (ButtonID) -> Void = { _ in }
    private var parkingSpaces: [ParkingSpace] = []

    private lazy var rootView = HomeView(didTapButton: { buttonId in self.didTapButton(buttonId) })

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
        viewModel.input.viewDidLoad()
        bindProperties()
        buttonActions()
        title = "Estacionamento Fácil"
    }
    
    func bindProperties() {
        viewModel.output.parkingSpaces.bind() { result in
            self.parkingSpaces = result
            self.setColors(parkingSpaces: result)
        }
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

    // MARK: - Actions
    private func buttonActions() {
        let email = Current.shared.email
        self.didTapButton = { buttonId in
            let parkingSpaces = self.parkingSpaces.filter({ $0.numSpace == buttonId.rawValue.description })
            
            if let idParkingSpace = parkingSpaces.first {
                if idParkingSpace.statusSpace == .busy {
                    self.showAlertTwoActions(
                        title: "Vaga \(idParkingSpace.numSpace) ocupada",
                        message: "CPF do cliente: \(idParkingSpace.cpfClient)"
                    ) {
                        let emptyParkingSpace = ParkingSpace(
                            _id: idParkingSpace._id,
                            numSpace: idParkingSpace.numSpace,
                            statusSpace: .free,
                            cpfClient: "",
                            emailFirebase: email
                        )
                        self.viewModel.occupyParkingSpace(
                            parkingSpace: emptyParkingSpace,
                            id: idParkingSpace._id) { success in
                                self.viewDidLoad()
                            }
                    }
                }
                self.viewModel.didTapParkingSpace(
                    buttonId,
                    idParkingSpace: idParkingSpace._id
                )
            } else {
                self.viewModel.didTapParkingSpace(
                    buttonId,
                    idParkingSpace: ""
                )
            }
        }
    }
}

extension HomeViewController {
    private func setColors(parkingSpaces: [ParkingSpace]) {
        guard let first = parkingSpaces.first(where: ( { $0.numSpace == "1" } )) else { return }
        guard let second = parkingSpaces.first(where: ( { $0.numSpace == "2" } )) else { return }
        guard let third = parkingSpaces.first(where: ( { $0.numSpace == "3" } )) else { return }
        guard let fourth = parkingSpaces.first(where: ( { $0.numSpace == "4" } )) else { return }
        guard let fifth = parkingSpaces.first(where: ( { $0.numSpace == "5" } )) else { return }
        guard let sixth = parkingSpaces.first(where: ( { $0.numSpace == "6" } )) else { return }
        guard let seventh = parkingSpaces.first(where: ( { $0.numSpace == "7" } )) else { return }
        guard let eighth = parkingSpaces.first(where: ( { $0.numSpace == "8" } )) else { return }
        guard let ninth = parkingSpaces.first(where: ( { $0.numSpace == "9" } )) else { return }
        
        self.rootView.setFirstColor(setColor(first.statusSpace))
        self.rootView.setSecondColor(setColor(second.statusSpace))
        self.rootView.setThirdColor(setColor(third.statusSpace))
        self.rootView.setFourthColor(setColor(fourth.statusSpace))
        self.rootView.setFifthColor(setColor(fifth.statusSpace))
        self.rootView.setSixthColor(setColor(sixth.statusSpace))
        self.rootView.setSeventhColor(setColor(seventh.statusSpace))
        self.rootView.setEighthColor(setColor(eighth.statusSpace))
        self.rootView.setNinthColor(setColor(ninth.statusSpace))
    }
    
    private func setColor(_ status: ParkingSpaceStatus) -> UIColor {
        switch status {
        case .free: return .systemGreen
        case .busy: return .systemYellow
        case .inMaintenance: return .systemRed
        }
    }
}
