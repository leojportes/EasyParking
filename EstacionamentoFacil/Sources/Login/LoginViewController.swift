//
//  LoginViewController.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 24/10/22.
//

import UIKit

class LoginViewController: CoordinatedViewController {
    
    // MARK: - Private properties
    private let viewModel: LoginViewModelProtocol

    private lazy var rootView = LoginView(
        didTapLogin: { self.viewModel.navigateToHome() }
    )

    // MARK: - Init
    init(viewModel: LoginViewModelProtocol, coordinator: CoordinatorProtocol) {
        self.viewModel = viewModel
        super.init(coordinator: coordinator)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = rootView
    }

}
