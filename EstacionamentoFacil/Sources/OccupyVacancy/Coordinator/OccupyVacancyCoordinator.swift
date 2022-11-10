//
//  OccupyVacancyCoordinator.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 07/11/22.
//

import Foundation

final class OccupyVacancyCoordinator: BaseCoordinator {
    
    func start(idParkingSpace: String, indexParkingSpace: String) {
        let viewModel = OccupyVacancyViewModel(coordinator: self)
        let controller = OccupyVacancyViewController(viewModel: viewModel, coordinator: self)
        controller.setParkingSpace(id: idParkingSpace, index: indexParkingSpace)
        configuration.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        configuration.navigationController?.pushViewController(controller, animated: true)
        configuration.navigationController?.navigationBar.tintColor = .darkGray
    }

    func dismiss() {
        configuration.navigationController?.popViewController(animated: true)
    }

    func navigateToClientDetails(_ clientModel: ClientDetailModel) {
        let coordinator = ClientDetailsCoordinator(with: configuration)
        coordinator.start(clientModel)
    }

    func navigateToRegisterNewClient() {
        let coordinator = RegisterNewClientCoordinator(with: configuration)
        coordinator.start()
    }
}
