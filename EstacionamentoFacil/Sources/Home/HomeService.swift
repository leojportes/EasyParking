//
//  HomeService.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 02/11/22.
//

import Foundation

protocol HomeServiceProtocol {
//    func getProcedureList(completion: @escaping ([GetProcedureModel]) -> Void)
    
}

class HomeService: HomeServiceProtocol {

//    // Get procedure list
//    func getProcedureList(completion: @escaping ([GetProcedureModel]) -> Void) {
//        guard let email = Auth.auth().currentUser?.email else { return }
//
//        let urlString = "http://54.86.122.10:3000/procedure/\(email)"
//        guard let url = URL(string: urlString) else { return }
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard let data = data else { return }
//            do {
//                let result = try JSONDecoder().decode([GetProcedureModel].self, from: data)
//                DispatchQueue.main.async {
//                    completion(result)
//                }
//            }
//            catch {
//                let error = error
//                print(error)
//            }
//        }.resume()
//    }

}
