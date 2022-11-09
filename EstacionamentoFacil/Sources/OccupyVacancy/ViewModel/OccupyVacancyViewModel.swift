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
  
    func didTapParkingSpace()
    func dismiss()
}

// MARK: - Protocols
protocol OccupyVacancyViewModelOutputProtocol {
    var clients: Bindable<[ClientModel]> { get }
}

protocol OccupyVacancyViewModelInputProtocol {
    func viewDidLoad()
//    func makeTotalAmounts(_ procedures: [GetProcedureModel]) -> String
}

class OccupyVacancyViewModel: OccupyVacancyViewModelProtocol, OccupyVacancyViewModelOutputProtocol {

    private let service: OccupyVacancyServiceProtocol

    var input: OccupyVacancyViewModelInputProtocol { self }
    var output: OccupyVacancyViewModelOutputProtocol { self }
    var clients: Bindable<[ClientModel]> = .init([])

    // MARK: - Properties
    private var coordinator: OccupyVacancyCoordinator?

    // MARK: - Init
    init(service: OccupyVacancyServiceProtocol = OccupyVacancyService(), coordinator: OccupyVacancyCoordinator?) {
        self.coordinator = coordinator
        self.service = service
    }

    private func fetchAllClients() {
        service.getClientsList { result in
            DispatchQueue.main.async {
                self.clients.value = result
            }
        }
    }
  
    func didTapParkingSpace() {
        
    }

    func dismiss() {
        coordinator?.dismiss()
    }
}

extension OccupyVacancyViewModel: OccupyVacancyViewModelInputProtocol {
    func viewDidLoad() {
        fetchAllClients()
    }
}

