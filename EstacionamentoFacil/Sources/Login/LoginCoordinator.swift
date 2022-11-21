//
//  LoginCoordinator.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 24/10/22.
//

import UIKit

final class LoginCoordinator: BaseCoordinator {
    
    override func start() {
        let viewModel = LoginViewModel(coordinator: self)
        let controller = LoginViewController(viewModel: viewModel, coordinator: self)
        configuration.navigationController?.pushViewController(controller, animated: true)
    }

    func navigateToHome() {
        let coordinator = HomeCoordinator(with: configuration)
        coordinator.start()
    }
    
    func navigateToCreateAccount() {
        let coordinator = CreateAccountCoordinator(with: configuration)
        coordinator.start()
    }
}
