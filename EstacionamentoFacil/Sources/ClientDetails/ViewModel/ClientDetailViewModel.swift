//
//  ClientDetailViewModel.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 09/11/22.
//

import UIKit

protocol ClientDetailsViewModelProtocol {
    func occupyParkingSpace(parkingSpace: ParkingSpace, id: String, completion: @escaping (Bool) -> Void)
    func popToHome()
    func dismiss()
}

class ClientDetailsViewModel: ClientDetailsViewModelProtocol {

    private let service: ClientDetailsServiceProtocol

    // MARK: - Properties
    private var coordinator: ClientDetailsCoordinator?

    // MARK: - Init
    init(service: ClientDetailsServiceProtocol = ClientDetailsService(), coordinator: ClientDetailsCoordinator?) {
        self.coordinator = coordinator
        self.service = service
    }

    func occupyParkingSpace(parkingSpace: ParkingSpace, id: String, completion: @escaping (Bool) -> Void) {
        service.occupyParkingSpace(parkingSpace: parkingSpace, id: id, completion: completion)
    }

    func didTapClientToOccupyVacancy(_ client: ClientModel) {
       
    }
    
    func popToHome() {
        coordinator?.popToHome()
    }

    func dismiss() {
        coordinator?.dismiss()
    }
}
