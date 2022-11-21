//
//  ClientDetailsCoordinator.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 09/11/22.
//

import Foundation

final class ClientDetailsCoordinator: BaseCoordinator {

    func start(_ clientModel: ClientDetailModel, _ numParkingSpace: String) {
        let viewModel = ClientDetailsViewModel(coordinator: self)
        let controller = ClientDetailsViewController(clientModel, numParkingSpace, viewModel: viewModel, coordinator: self)
        configuration.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        configuration.navigationController?.pushViewController(controller, animated: true)
    }

    func dismiss() {
        configuration.navigationController?.popViewController(animated: true)
    }

    func popToHome() {
        let controller = HomeCoordinator(with: configuration)
        controller.start()
    }
}
