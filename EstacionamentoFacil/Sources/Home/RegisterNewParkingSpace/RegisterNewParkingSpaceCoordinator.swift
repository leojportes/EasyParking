//
//  RegisterNewParkingSpaceCoordinator.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 12/11/22.
//

import UIKit

final class RegisterNewParkingSpaceCoordinator: BaseCoordinator {

    func start(parkingSpaces: [ParkingSpace]) {
        let viewModel = RegisterNewParkingSpaceViewModel(coordinator: self)
        let controller = RegisterNewParkingSpaceController(
            parkingSpaces: parkingSpaces,
            viewModel: viewModel,
            coordinator: self
        )
        let apperance = UINavigationBarAppearance()
        apperance.backgroundColor = UIColor(named: "lightGray")
        configuration.navigationController?.navigationBar.scrollEdgeAppearance = apperance
        configuration.navigationController?.pushViewController(controller, animated: true)
    }
    
    func dismiss() {
        configuration.navigationController?.popViewController(animated: true)
    }
}
