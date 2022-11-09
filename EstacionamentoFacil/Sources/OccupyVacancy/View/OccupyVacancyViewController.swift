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

    private lazy var rootView = OccupyVacancyView(
        didTapOccupyVacancyButton: { },
        didTapCancelButton: { self.viewModel.dismiss() }
    )

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
        bindProperties()
        
    }

    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    private func bindProperties() {
        viewModel.input.viewDidLoad()
        viewModel.output.clients.bind() { result in
            print("Clients", result)
        }
    }
}
