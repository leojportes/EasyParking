//
//  LoginViewController.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 24/10/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: CoordinatedViewController {
    
    // MARK: - Private properties
    private let viewModel: LoginViewModelProtocol

    private lazy var rootView = LoginView(
        didTapLogin: weakify { $0.didTapLogin($1, $2) },
        didTapCreateAccount: weakify { $0.viewModel.navigateToCreateAccount() }
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
        hideKeyboardWhenTappedAround()
    }

    func didTapLogin(_ email: String, _ password: String) {
        rootView.loginButton.loadingIndicator(show: true)
        viewModel.authLogin(email, password) { [weak self] onSuccess, descriptionError in
            onSuccess
            ? DispatchQueue.main.async { self?.viewModel.navigateToHome() }
            : DispatchQueue.main.async { self?.showError(descriptionError) }
        }
    }
    
    private func showError( _ descriptionError: String) {
        self.showAlert(title: "Atenção", message: descriptionError)
        self.rootView.loginButton.loadingIndicator(show: false)
    }
//
//    func didTapForgotPassword() {
//        viewModel.navigateToForgotPassword(email: self.email)
//    }
//
//    func didTapRegister() {
//        viewModel.navigateToRegister()
//    }
//
}
