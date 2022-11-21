//
//  OccupyVacancyCoordinator.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 07/11/22.
//

import UIKit

final class OccupyVacancyCoordinator: BaseCoordinator {
    
    func start(parkingSpace: ParkingSpace) {
        let viewModel = OccupyVacancyViewModel(coordinator: self)
        let controller = OccupyVacancyViewController(viewModel: viewModel, coordinator: self)
        controller.setParkingSpace(parkingSpace: parkingSpace)
        configuration.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        configuration.navigationController?.pushViewController(controller, animated: true)
        configuration.navigationController?.navigationBar.tintColor = .darkGray
    }

    func dismiss() {
        configuration.navigationController?.popViewController(animated: true)
    }

    func navigateToClientDetails(_ clientModel: ClientDetailModel, _ numParkingSpace: String) {
        let coordinator = ClientDetailsCoordinator(with: configuration)
        coordinator.start(clientModel, numParkingSpace)
    }

    func navigateToRegisterNewClient() {
        let coordinator = RegisterNewClientCoordinator(with: configuration)
        coordinator.start()
    }
}
