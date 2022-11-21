//
//  OccupyVacancyViewController.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 07/11/22.
//

import UIKit

class OccupyVacancyViewController: CoordinatedViewController {

    // MARK: - Private properties
    private let viewModel: OccupyVacancyViewModelProtocol
    private var searchText = ""
    private var indexParkingSpace: String = ""
    private var idParkingSpace: String = ""
    private var parkingSpace: ParkingSpace = .none

    private lazy var rootView = OccupyVacancyView(
        parkingSpace: self.parkingSpace,
        didTapRegisterClientButton: { self.viewModel.navigateToRegisterNewClient() },
        didTapClient: { [weak self] client in self?.didTapClient(client) },
        showAlert: { self.showAlert(
            title: "Escolha outro cliente!",
            message: "Cliente já ocupando uma vaga."
        ) }
    )

    private lazy var searchVC = UISearchController()
    private var clientsItems: [ClientModel] = []

    // MARK: - Init
    init(viewModel: OccupyVacancyViewModelProtocol, coordinator: CoordinatorProtocol) {
        self.viewModel = viewModel
        super.init(coordinator: coordinator)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ocupar Vaga nº \(self.indexParkingSpace)"
        createSearchBar()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .trash,
            target: self,
            action: #selector(deleteParkingSpace)
        )

    }

    override func loadView() {
        super.loadView()
        view = rootView
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bindProperties()
    }

    private func bindProperties() {
        /// Fetch all clients from api
        viewModel.input.viewDidLoad()
        viewModel.output.clients.bind() { [weak self] result in
            self?.clientsItems = result
            self?.rootView.clientItems = result
        }
        
        viewModel.output.parkingSpaces.bind() { [weak self] result in
            self?.rootView.parkingSpaces = result
        }
    }

    private func createSearchBar() {
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
        searchVC.searchBar.placeholder = "Filtre uma placa. ex: abc0000"
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    // MARK: - Actions
    private func didTapClient(_ client: ClientModel) {
        let clientModel = ClientDetailModel(
            client: client,
            indexParkingSpace: self.indexParkingSpace,
            idParkingSpace: self.idParkingSpace
        )
        viewModel.didTapClientToOccupyVacancy(clientModel, self.indexParkingSpace)
    }

    private func didTapRegisterNewClient() {
        viewModel.navigateToRegisterNewClient()
    }

    func setParkingSpace(parkingSpace: ParkingSpace) {
        self.indexParkingSpace = parkingSpace.numSpace
        self.parkingSpace = parkingSpace
        self.idParkingSpace = parkingSpace._id
    }
    
    @objc private func deleteParkingSpace() {
        self.showAlertTwoActions(
            title: "Atenção!",
            message: "Deseja apagar a vaga nº \(self.indexParkingSpace) ?",
            leftButtonTitle: "Cancelar",
            rightButtonTitle: "Apagar"
        ) {
            self.viewModel.deleteParkingSpace(id: self.idParkingSpace) { success in
                if success {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Vaga deletada!") {
                            self.viewModel.dismiss()
                        }
                    }
                } else {
                    self.showAlert(
                        title: "Ops!",
                        message: "Tivemos algum problema ao deletar a vaga."
                    ) {
                        self.viewModel.dismiss()
                    }
                }
            }
        }
    }
}

extension OccupyVacancyViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let filteredIcons = clientsItems.filter { $0.plate.lowercased().contains(searchText.lowercased()) }
        self.rootView.clientItems =  searchText.isEmpty == false ? filteredIcons : self.clientsItems
        
        self.searchText = searchText
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = searchText
    }
}
