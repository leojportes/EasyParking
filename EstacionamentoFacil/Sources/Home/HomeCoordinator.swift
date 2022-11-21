//
//  HomeCoordinator.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 02/11/22.
//

import UIKit

final class HomeCoordinator: BaseCoordinator {

    override func start() {
        let viewModel = HomeViewModel(coordinator: self)
        let controller = HomeViewController(viewModel: viewModel, coordinator: self)
        let apperance = UINavigationBarAppearance()
        apperance.backgroundColor = UIColor(named: "lightGray")
        configuration.navigationController?.navigationBar.scrollEdgeAppearance = apperance
        configuration.navigationController?.navigationBar.tintColor = .darkGray
        configuration.navigationController?.pushViewController(controller, animated: true)
    }

    func navigateToVehiclesList(parkingSpace: ParkingSpace) {
        let coordinator = OccupyVacancyCoordinator(with: configuration)
        coordinator.start(parkingSpace: parkingSpace)
    }

    func navigateToRegisterNewParkingSpace(parkingSpaces: [ParkingSpace]) {
        let coordinator = RegisterNewParkingSpaceCoordinator(with: configuration)
        coordinator.start(parkingSpaces: parkingSpaces)
    }

    func logout() {
        let coordinator = LoginCoordinator(with: configuration)
        configuration.navigationController?.dismiss(animated: true)
        configuration.navigationController?.viewControllers.removeAll()
        coordinator.start()
    }
}
