//
//  ClientDetailsService.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 09/11/22.
//

import Foundation
//import FirebaseAuth

protocol ClientDetailsServiceProtocol {
    func occupyParkingSpace(parkingSpace: ParkingSpace, id: String, completion: @escaping (Bool) -> Void)
    func deleteClient(id: String, completion: @escaping (Bool) -> Void)
}

class ClientDetailsService: ClientDetailsServiceProtocol {
    private let baseUrl = ClientAPI.endpoint
    
    func occupyParkingSpace(parkingSpace: ParkingSpace, id: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(ClientAPI.endpoint)/parkingSpace/\(id)") else {
            print("Error: cannot create URL")
            return
        }

        /// Convert model to JSON data
        guard let jsonData = try? JSONEncoder().encode(parkingSpace) else {
            print("Error: Trying to convert model to JSON data")
            return
        }

        /// Create the url request
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
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
    
    func deleteClient(id: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(baseUrl)/client/\(id)") else {
            print("Error: cannot create URL")
            return
        }
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: urlReq) { data, response, error in
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
