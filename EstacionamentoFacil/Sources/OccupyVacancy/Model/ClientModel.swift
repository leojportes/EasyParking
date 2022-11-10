//
//  ClientModel.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 07/11/22.
//

import Foundation

struct ClientModel: Codable {
    let emailFirebase: String
    let clientName: String
    let cpfClient: String
    let plate: String
    let model: String
    let color: String
}
