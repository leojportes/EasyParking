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
    func didTapParkingSpace(_ buttonId: ButtonID)
}

// MARK: - Protocols
protocol HomeViewModelOutputProtocol {
    
}

protocol HomeViewModelInputProtocol {
    func viewDidLoad()
//    func makeTotalAmounts(_ procedures: [GetProcedureModel]) -> String
}

class HomeViewModel: HomeViewModelProtocol, HomeViewModelOutputProtocol {

    private let service: HomeServiceProtocol

    var input: HomeViewModelInputProtocol { self }
    var output: HomeViewModelOutputProtocol { self }
//    var procedures: Bindable<[GetProcedureModel]> = .init([])

    // MARK: - Properties
    private var coordinator: HomeCoordinator?

    // MARK: - Init
    init(service: HomeServiceProtocol = HomeService(), coordinator: HomeCoordinator?) {
        self.coordinator = coordinator
        self.service = service
    }

//    private func fetchProcedureItems() {
//        service.getProcedureList { result in
//            DispatchQueue.main.async {
//                self.procedures.value = result
//            }
//        }
//    }
  
    // MARK: - Routes
    func didTapParkingSpace(_ buttonId: ButtonID) {
        print("Número do botão: ", buttonId.rawValue)
        coordinator?.navigateToVehiclesList(buttonId)
    }

}

extension HomeViewModel: HomeViewModelInputProtocol {
    func viewDidLoad() {
        
    }
}

