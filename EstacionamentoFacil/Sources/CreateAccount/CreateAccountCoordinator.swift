//
//  CreateAccountCoordinator.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 09/11/22.
//

import Foundation

final class CreateAccountCoordinator: BaseCoordinator {
    override func start() {
        let viewModel = CreateAccountViewModel(coordinator: self)
        let controller = CreateAccountViewController(viewModel: viewModel, coordinator: self)
        configuration.viewController = controller
        configuration.navigationController?.present(controller, animated: true)
    }
    
    func closed() {
        configuration.navigationController?.dismiss(animated: true)
    }
}
