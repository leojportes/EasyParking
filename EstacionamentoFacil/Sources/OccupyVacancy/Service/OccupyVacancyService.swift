//
//  OccupyVacancyService.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 07/11/22.
//

import Foundation
import FirebaseAuth

protocol OccupyVacancyServiceProtocol {
    func getClientsList(completion: @escaping ([ClientModel]) -> Void)
    func deleteParkingSpace(id: String, completion: @escaping (Bool) -> Void)
    func getParkingSpaces(completion: @escaping ([ParkingSpace]) -> Void)
}

class OccupyVacancyService: OccupyVacancyServiceProtocol {
    private let baseUrl = ClientAPI.endpoint
    
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
    
    /// Delete parking space
    func deleteParkingSpace(id: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(baseUrl)/parkingSpace/\(id)") else {
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
    
}
