//
//  CreateAccountViewModel.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 09/11/22.
//

import FirebaseAuth
import Foundation

protocol CreateAccountViewModelProtocol: AnyObject {
    func createAccount(_ email: String, _ password: String, resultCreateUser: @escaping (Bool, String) -> Void)
    func closed()
}

class CreateAccountViewModel: CreateAccountViewModelProtocol {
    
    // MARK: - Properties
    private var coordinator: CreateAccountCoordinator?
    
    // MARK: - Init
    init(coordinator: CreateAccountCoordinator?) {
        self.coordinator = coordinator
    }
    
    func createAccount(_ email: String, _ password: String, resultCreateUser: @escaping (Bool, String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                guard let typeError = error as? NSError else { return }
                resultCreateUser(false, self.descriptionError(error: typeError))
            } else {
                resultCreateUser(true, "")
                DispatchQueue.main.async {
                    self.createInitialParkingSpaces() { success in
                        success ? resultCreateUser(true, "") : resultCreateUser(false, "Erro ao criar vagas iniciais.")
                    }
                }
            }
        }
    }

    private func createInitialParkingSpaces(completion: @escaping (Bool) -> Void) {
        let email = Current.shared.email
        let initialParkingSpace = InitialParkingSpace(emailFirebase: email)
        
        guard let url = URL(string: "\(ClientAPI.endpoint)/parkingSpace") else {
            print("Error: cannot create URL")
            return
        }

        /// Convert model to JSON data
        guard let jsonData = try? JSONEncoder().encode(initialParkingSpace) else {
            print("Error: Trying to convert model to JSON data")
            return
        }

        /// Create the url request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(false)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                completion(false)
                return
            }
            DispatchQueue.main.async {
                completion(true)
            }
        }.resume()
    }
    
    private func descriptionError(error: NSError) -> String {
        switch error.code {
        case AuthErrorCode.invalidEmail.rawValue: return "E-mail invalido"
        case AuthErrorCode.emailAlreadyInUse.rawValue: return "Já existe uma conta com esse e-mail"
        case AuthErrorCode.weakPassword.rawValue: return "Adicione uma senha com no mínimo 6 digitos"
        default: return "Tente novamente mais tarde"
        }
    }
    
    // MARK: - Routes
    func closed() {
        coordinator?.closed()
    }
    
}
