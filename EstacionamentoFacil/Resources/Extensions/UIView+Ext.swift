//
//  UIView+Ext.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 02/11/22.
//

import UIKit

extension UIView {
    func addShadow(color: UIColor? = .black, size: CGSize = CGSize(width: 0.0, height: 1), opacity: Float = 0.3, radius: CGFloat = 2) {
        self.layer.shadowColor = color?.cgColor
        self.layer.shadowOffset = size
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
}
