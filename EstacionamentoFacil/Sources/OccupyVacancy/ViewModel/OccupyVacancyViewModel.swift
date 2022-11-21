//
//  OccupyVacancyViewModel.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 07/11/22.
//

import UIKit

protocol OccupyVacancyViewModelProtocol: AnyObject {
    var input: OccupyVacancyViewModelInputProtocol { get }
    var output: OccupyVacancyViewModelOutputProtocol { get }
  
    func didTapClientToOccupyVacancy(_ clientModel: ClientDetailModel, _ numParkingSpace: String)
    func navigateToRegisterNewClient()
    func deleteParkingSpace(id: String, completion: @escaping (Bool) -> Void)
    func getParkingSpaces()
    func dismiss()
}

// MARK: - Protocols
protocol OccupyVacancyViewModelOutputProtocol {
    var clients: Bindable<[ClientModel]> { get }
    var parkingSpaces: Bindable<[ParkingSpace]> { get }
}

protocol OccupyVacancyViewModelInputProtocol {
    func viewDidLoad()
}

class OccupyVacancyViewModel: OccupyVacancyViewModelProtocol, OccupyVacancyViewModelOutputProtocol {

    private let service: OccupyVacancyServiceProtocol

    var input: OccupyVacancyViewModelInputProtocol { self }
    var output: OccupyVacancyViewModelOutputProtocol { self }
    var clients: Bindable<[ClientModel]> = .init([])
    var parkingSpaces: Bindable<[ParkingSpace]> = .init([])

    // MARK: - Properties
    private var coordinator: OccupyVacancyCoordinator?

    // MARK: - Init
    init(service: OccupyVacancyServiceProtocol = OccupyVacancyService(), coordinator: OccupyVacancyCoordinator?) {
        self.coordinator = coordinator
        self.service = service
    }

    /// Fetch all clients
    private func fetchClients() {
        service.getClientsList { result in
            DispatchQueue.main.async {
                self.clients.value = result
            }
        }
    }

    /// Delete Parking Space
    func deleteParkingSpace(id: String, completion: @escaping (Bool) -> Void) {
        service.deleteParkingSpace(id: id, completion: completion)
    }

    func getParkingSpaces() {
        service.getParkingSpaces() { result in
            DispatchQueue.main.async {
                self.parkingSpaces.value = result
            }
        }
    }
  
    // MARK: - Routes
    func didTapClientToOccupyVacancy(_ clientModel: ClientDetailModel, _ numParkingSpace: String) {
        coordinator?.navigateToClientDetails(clientModel, numParkingSpace)
    }

    func navigateToRegisterNewClient() {
        coordinator?.navigateToRegisterNewClient()
    }

    func dismiss() {
        coordinator?.dismiss()
    }
}

extension OccupyVacancyViewModel: OccupyVacancyViewModelInputProtocol {
    func viewDidLoad() {
        fetchClients()
        getParkingSpaces()
    }
}

