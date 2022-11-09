//
//  TextField+Ext.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 24/10/22.
//

import UIKit

extension UITextField {
    
    func setPaddingLeft() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
