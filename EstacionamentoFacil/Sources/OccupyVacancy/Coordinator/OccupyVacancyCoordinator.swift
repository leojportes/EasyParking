//
//  OccupyVacancyCoordinator.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 07/11/22.
//

import Foundation

final class OccupyVacancyCoordinator: BaseCoordinator {
    
    override func start() {
        let viewModel = OccupyVacancyViewModel(coordinator: self)
        let controller = OccupyVacancyViewController(viewModel: viewModel, coordinator: self)
        configuration.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        configuration.navigationController?.pushViewController(controller, animated: true)
        configuration.navigationController?.navigationBar.tintColor = .darkGray
    }

    func dismiss() {
        configuration.navigationController?.popViewController(animated: true)
    }

}
