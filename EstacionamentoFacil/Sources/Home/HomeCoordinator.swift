//
//  HomeCoordinator.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 02/11/22.
//

import Foundation

final class HomeCoordinator: BaseCoordinator {

    override func start() {
        let viewModel = HomeViewModel(coordinator: self)
        let controller = HomeViewController(viewModel: viewModel, coordinator: self)
        configuration.navigationController?.pushViewController(controller, animated: true)
    }

    func navigateToVehiclesList(_ buttonId: ButtonID, idParkingSpace: String) {
        let coordinator = OccupyVacancyCoordinator(with: configuration)
        coordinator.start(
            idParkingSpace: idParkingSpace,
            indexParkingSpace: buttonId.rawValue.description
        )
    }

}
