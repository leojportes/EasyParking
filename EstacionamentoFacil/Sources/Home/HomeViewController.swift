//
//  HomeViewController.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 02/11/22.
//

import UIKit

class HomeViewController: CoordinatedViewController {

    // MARK: - Private properties
    private let viewModel: HomeViewModelProtocol
    private var didTapButton: (ButtonID) -> Void = { _ in }

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
        buttonActions()
        title = "Estacionamento Fácil"
    }

    override func loadView() {
        super.loadView()
        view = rootView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.setHidesBackButton(false, animated: true)
    }

    // MARK: - Actions
    private func buttonActions() {
        self.didTapButton = { buttonId in self.viewModel.didTapParkingSpace(buttonId) }
    }

}
