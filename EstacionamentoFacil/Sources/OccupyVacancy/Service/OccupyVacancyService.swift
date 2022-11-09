//
//  OccupyVacancyService.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 07/11/22.
//

import Foundation
//import FirebaseAuth

protocol OccupyVacancyServiceProtocol {
    func getClientsList(completion: @escaping ([ClientModel]) -> Void)
}

class OccupyVacancyService: OccupyVacancyServiceProtocol {

    // Get procedure list
    func getClientsList(completion: @escaping ([ClientModel]) -> Void) {
//        guard let email = Auth.auth().currentUser?.email else { return }
        // let urlString = "http://localhost:3000/clients/\(email)"
        let urlString = "http://localhost:3000/clients/leojportes@gmail.com"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode([ClientModel].self, from: data)
                DispatchQueue.main.async { completion(result) }
            }
            catch {
                let error = error
            }
        }.resume()
    }

}
