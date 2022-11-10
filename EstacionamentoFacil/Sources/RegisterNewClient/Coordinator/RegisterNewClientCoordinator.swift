//
//  RegisterNewClientCoordinator.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 09/11/22.
//

import Foundation

final class RegisterNewClientCoordinator: BaseCoordinator {
    
    override func start() {
        let viewModel = RegisterNewClientViewModel(coordinator: self)
        let controller = RegisterNewClientViewController(viewModel: viewModel, coordinator: self)
        configuration.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        configuration.navigationController?.pushViewController(controller, animated: true)
        configuration.navigationController?.navigationBar.tintColor = .darkGray
    }

    func dismiss() {
        configuration.navigationController?.popViewController(animated: true)
    }

}
