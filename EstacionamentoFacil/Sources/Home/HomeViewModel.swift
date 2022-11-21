//
//  HomeViewModel.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 02/11/22.
//

import UIKit
import FirebaseAuth

protocol HomeViewModelProtocol: AnyObject {
    var input: HomeViewModelInputProtocol { get }
    var output: HomeViewModelOutputProtocol { get }
  
    // Routes
    func didTapParkingSpace(parkingSpace: ParkingSpace)
    func navigateToRegisterNewParkingSpace(_ parkingSpaces: [ParkingSpace])
    func signOut(resultSignOut: (Bool) -> Void)
    func logout()
    func occupyParkingSpace(parkingSpace: ParkingSpace, id: String, completion: @escaping (Bool) -> Void)
}

// MARK: - Protocols
protocol HomeViewModelOutputProtocol {
    var parkingSpaces: Bindable<[ParkingSpace]> { get }
    var clients: Bindable<[ClientModel]> { get }
}

protocol HomeViewModelInputProtocol {
    func viewDidLoad()
}

class HomeViewModel: HomeViewModelProtocol, HomeViewModelOutputProtocol {

    private let service: HomeServiceProtocol

    var input: HomeViewModelInputProtocol { self }
    var output: HomeViewModelOutputProtocol { self }
    var parkingSpaces: Bindable<[ParkingSpace]> = .init([])
    var clients: Bindable<[ClientModel]> = .init([])

    // MARK: - Properties
    private var coordinator: HomeCoordinator?

    // MARK: - Init
    init(service: HomeServiceProtocol = HomeService(), coordinator: HomeCoordinator?) {
        self.coordinator = coordinator
        self.service = service
    }

    /// Fetch all parkingSpaces
    private func fetchParkingSpaces() {
        service.getParkingSpaces { result in
            DispatchQueue.main.async {
                self.parkingSpaces.value = result
            }
        }
    }
    
    /// Fetch all clients
    private func fetchClients() {
        service.getClientsList { result in
            DispatchQueue.main.async {
                self.clients.value = result
            }
        }
    }

    func occupyParkingSpace(parkingSpace: ParkingSpace, id: String, completion: @escaping (Bool) -> Void) {
        service.occupyParkingSpace(parkingSpace: parkingSpace, id: id, completion: completion)
    }
  
    // MARK: - Routes
    func didTapParkingSpace(parkingSpace: ParkingSpace) {
        coordinator?.navigateToVehiclesList(parkingSpace: parkingSpace)
    }
    
    func navigateToRegisterNewParkingSpace(_ parkingSpaces: [ParkingSpace]) {
        coordinator?.navigateToRegisterNewParkingSpace(parkingSpaces: parkingSpaces)
    }
    
    func signOut(resultSignOut: (Bool) -> Void) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            resultSignOut(true)
        } catch {
            resultSignOut(false)
        }
    }
    
    func logout() {
        coordinator?.logout()
    }

}

extension HomeViewModel: HomeViewModelInputProtocol {
    func viewDidLoad() {
        fetchParkingSpaces()
        fetchClients()
    }
}
