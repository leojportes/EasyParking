//
//  RegisterNewClientViewModel.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 09/11/22.
//

import UIKit

protocol RegisterNewClientViewModelProtocol {
    func createNewClient(client: ClientModel, completion: @escaping (Bool) -> Void)
    func dismiss()
}

class RegisterNewClientViewModel: RegisterNewClientViewModelProtocol {

    private let service: RegisterNewClientServiceProtocol

    // MARK: - Properties
    private var coordinator: RegisterNewClientCoordinator?

    // MARK: - Init
    init(service: RegisterNewClientServiceProtocol = RegisterNewClientService(), coordinator: RegisterNewClientCoordinator?) {
        self.coordinator = coordinator
        self.service = service
    }

    func createNewClient(client: ClientModel, completion: @escaping (Bool) -> Void) {
        service.createNewClient(client: client, completion: completion)
    }

    func didTapClientToOccupyVacancy(_ client: ClientDetailModel) {
       
    }

    func dismiss() {
        coordinator?.dismiss()
    }
}
