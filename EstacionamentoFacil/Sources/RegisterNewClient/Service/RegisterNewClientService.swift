//
//  RegisterNewClientService.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 09/11/22.
//

import Foundation
//import FirebaseAuth

protocol RegisterNewClientServiceProtocol {
    func createNewClient(client: ClientModel, completion: @escaping (Bool) -> Void)
}

class RegisterNewClientService: RegisterNewClientServiceProtocol {
    private let baseUrl = ClientAPI.endpoint
    
    func createNewClient(client: ClientModel, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(ClientAPI.endpoint)/client") else {
            print("Error: cannot create URL")
            return
        }
        /// Convert model to JSON data
        guard let jsonData = try? JSONEncoder().encode(client) else {
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

}
