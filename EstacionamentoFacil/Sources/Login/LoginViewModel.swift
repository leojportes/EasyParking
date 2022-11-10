//
//  LoginViewModel.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 02/11/22.
//

import UIKit
import FirebaseAuth
import FirebaseCore

protocol LoginViewModelProtocol: AnyObject {
    var input: LoginViewModelInputProtocol { get }
    var output: LoginViewModelOutputProtocol { get }
  
    func navigateToHome()
    func navigateToCreateAccount()
    func authLogin(_ email: String, _ password: String, resultLogin: @escaping (Bool, String) -> Void)
}

// MARK: - Protocols
protocol LoginViewModelOutputProtocol {
    
}

protocol LoginViewModelInputProtocol {
    func viewDidLoad()
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

    func authLogin(_ email: String, _ password: String, resultLogin: @escaping (Bool, String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if error != nil {
                guard let typeError = error as? NSError else { return }
                resultLogin(false, self.descriptionError(error: typeError))
            } else {
                resultLogin(true, "")
            }
        }
    }
  
    func navigateToHome() {
        coordinator?.navigateToHome()
    }
    
    func navigateToCreateAccount() {
        coordinator?.navigateToCreateAccount()
    }

}

extension LoginViewModel: LoginViewModelInputProtocol {
    func viewDidLoad() {
        
    }
    
    private func descriptionError(error: NSError) -> String {
        var description: String = ""
        
        switch error.code {
        case AuthErrorCode.userNotFound.rawValue:
            description = "Não existe uma conta com esse email"
        case AuthErrorCode.wrongPassword.rawValue:
            description = "senha incorreta"
        default:
            description = "Ocorreu um erro, tente novamente mais tarde"
        }
        
        return description
    }
}

