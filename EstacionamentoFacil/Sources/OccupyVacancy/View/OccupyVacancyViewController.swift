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

    private lazy var rootView = OccupyVacancyView(
        didTapRegisterClientButton: { self.viewModel.navigateToRegisterNewClient() },
        didTapClient: { client in self.didTapClient(client) }
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
        title = "Ocupar Vaga"
        createSearchBar()
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
        viewModel.output.clients.bind() { result in
            self.clientsItems = result
            self.rootView.clientItems = result
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
        viewModel.didTapClientToOccupyVacancy(clientModel)
    }

    private func didTapRegisterNewClient() {
        viewModel.navigateToRegisterNewClient()
    }

    func setParkingSpace(id: String, index: String) {
        self.indexParkingSpace = index
        self.idParkingSpace = id
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
