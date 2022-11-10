//
//  HomeViewModel.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 02/11/22.
//

import UIKit

protocol HomeViewModelProtocol: AnyObject {
    var input: HomeViewModelInputProtocol { get }
    var output: HomeViewModelOutputProtocol { get }
  
    // Routes
    func didTapParkingSpace(_ buttonId: ButtonID, idParkingSpace: String)
    func occupyParkingSpace(parkingSpace: ParkingSpace, id: String, completion: @escaping (Bool) -> Void)
}

// MARK: - Protocols
protocol HomeViewModelOutputProtocol {
    var parkingSpaces: Bindable<[ParkingSpace]> { get }
}

protocol HomeViewModelInputProtocol {
    func viewDidLoad()
}

class HomeViewModel: HomeViewModelProtocol, HomeViewModelOutputProtocol {

    private let service: HomeServiceProtocol

    var input: HomeViewModelInputProtocol { self }
    var output: HomeViewModelOutputProtocol { self }
    var parkingSpaces: Bindable<[ParkingSpace]> = .init([])

    // MARK: - Properties
    private var coordinator: HomeCoordinator?

    // MARK: - Init
    init(service: HomeServiceProtocol = HomeService(), coordinator: HomeCoordinator?) {
        self.coordinator = coordinator
        self.service = service
    }

    private func fetchParkingSpaces() {
        service.getParkingSpaces { result in
            DispatchQueue.main.async {
                self.parkingSpaces.value = result
            }
        }
    }
    
    func occupyParkingSpace(parkingSpace: ParkingSpace, id: String, completion: @escaping (Bool) -> Void) {
        service.occupyParkingSpace(parkingSpace: parkingSpace, id: id, completion: completion)
    }
  
    // MARK: - Routes
    func didTapParkingSpace(_ buttonId: ButtonID, idParkingSpace: String) {
        coordinator?.navigateToVehiclesList(buttonId, idParkingSpace: idParkingSpace)
    }

}

extension HomeViewModel: HomeViewModelInputProtocol {
    func viewDidLoad() {
        fetchParkingSpaces()
    }
}
