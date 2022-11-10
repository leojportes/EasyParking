//
//  ParkingSpaceModel.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 09/11/22.
//

import Foundation

struct ParkingSpace: Codable {
    let _id: String
    let numSpace: String
    let statusSpace: ParkingSpaceStatus
    let cpfClient: String
    let emailFirebase: String
}


public enum ParkingSpaceStatus: String, Codable {
    case free = "free"
    case busy = "busy"
    case inMaintenance = "inMaintenance"
}
