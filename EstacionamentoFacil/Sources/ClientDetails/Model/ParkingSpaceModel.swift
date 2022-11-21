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
    let firstDate: String
    
    public static var none: Self {
        ParkingSpace(
            _id: "",
            numSpace: "",
            statusSpace: .free,
            cpfClient: "",
            emailFirebase: "",
            firstDate: ""
        )
    }
}


public enum ParkingSpaceStatus: String, Codable {
    case free = "free"
    case busy = "busy"
    case inMaintenance = "inMaintenance"
}

public enum CreateParkingSpaceStatus: String, Codable {
    case free = "free"
    case inMaintenance = "inMaintenance"
}

struct CreateParkingSpace: Codable {
    let numSpace: String
    let statusSpace: ParkingSpaceStatus
    let cpfClient: String
    let emailFirebase: String
    let firstDate: String
}
