//
//  LoginViewModel.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 02/11/22.
//

import UIKit

protocol LoginViewModelProtocol: AnyObject {
    var input: LoginViewModelInputProtocol { get }
    var output: LoginViewModelOutputProtocol { get }
  
    func navigateToHome()
}

// MARK: - Protocols
protocol LoginViewModelOutputProtocol {
    
}

protocol LoginViewModelInputProtocol {
    func viewDidLoad()
//    func makeTotalAmounts(_ procedures: [GetProcedureModel]) -> String
}

class LoginViewModel: LoginViewModelProtocol, LoginViewModelOutputProtocol {

    private let service: LoginServiceProtocol

    var input: LoginViewModelInputProtocol { self }
    var output: LoginViewModelOutputProtocol { self }
//    var procedures: Bindable<[GetProcedureModel]> = .init([])

    // MARK: - Properties
    private var coordinator: LoginCoordinator?

    // MARK: - Init
    init(service: LoginServiceProtocol = LoginService(), coordinator: LoginCoordinator?) {
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
    
  
    func navigateToHome() {
        coordinator?.navigateToHome()
    }

}

extension LoginViewModel: LoginViewModelInputProtocol {
    func viewDidLoad() {
        
    }
}

