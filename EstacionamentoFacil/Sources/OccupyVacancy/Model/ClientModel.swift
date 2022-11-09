//
//  ClientModel.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 07/11/22.
//

import Foundation

struct ClientModel: Decodable {
    let emailFirebase: String
    let cpfClient: String
    let plate: String
    let model: String
    let color: String
}
