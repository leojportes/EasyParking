//
//  HomeService.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 02/11/22.
//

import Foundation
import FirebaseAuth

protocol HomeServiceProtocol {
    func getParkingSpaces(completion: @escaping ([ParkingSpace]) -> Void)
    func occupyParkingSpace(parkingSpace: ParkingSpace, id: String, completion: @escaping (Bool) -> Void)
    func getClientsList(completion: @escaping ([ClientModel]) -> Void)
}

class HomeService: HomeServiceProtocol {

    private let baseUrl = ClientAPI.endpoint
    
    // Get parking space list
    func getParkingSpaces(completion: @escaping ([ParkingSpace]) -> Void) {
        let email = Current.shared.email
        // let urlString = "http://localhost:3000/clients/\(email)"
        let urlString = "\(baseUrl)/parkingSpace/\(email)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode([ParkingSpace].self, from: data)
                DispatchQueue.main.async { completion(result) }
            }
            catch {
                let error = error
                print(error)
            }
        }.resume()
    }
    
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

    // Get clients list
    func getClientsList(completion: @escaping ([ClientModel]) -> Void) {
        let email = Current.shared.email
        let urlString = "\(baseUrl)/clients/\(email)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode([ClientModel].self, from: data)
                DispatchQueue.main.async { completion(result) }
            }
            catch {
                let error = error
                print(error)
            }
        }.resume()
    }

}
