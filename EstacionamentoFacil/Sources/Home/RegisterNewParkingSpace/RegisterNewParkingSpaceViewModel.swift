//
//  RegisterNewParkingSpaceViewModel.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 12/11/22.
//

import UIKit

protocol RegisterNewParkingSpaceViewModelProtocol: AnyObject {
    func createNew(parkingSpacing: CreateParkingSpace, completion: @escaping (Bool) -> Void)
    func dismiss()
}

class RegisterNewParkingSpaceViewModel: RegisterNewParkingSpaceViewModelProtocol {

    // MARK: - Private properties
    private var coordinator: RegisterNewParkingSpaceCoordinator?
    private let service: RegisterNewParkingSpaceServiceProtocol

    // MARK: - Init
    init(service: RegisterNewParkingSpaceServiceProtocol = RegisterNewParkingSpaceService(), coordinator: RegisterNewParkingSpaceCoordinator?) {
        self.coordinator = coordinator
        self.service = service
    }

    func createNew(parkingSpacing: CreateParkingSpace, completion: @escaping (Bool) -> Void) {
        service.createNew(parkingSpacing: parkingSpacing, completion: completion)
    }
    
    func dismiss() {
        coordinator?.dismiss()
    }

}
