//
//  Current.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 09/11/22.
//

import Foundation
import FirebaseAuth

class Current {
    static let shared: Current = Current()
    
    init() { /* empty init */ }
    
    public var email: String {
        Auth.auth().currentUser?.email ?? ""
    }

}
