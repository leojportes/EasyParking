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

extension UIView {
    
    /// Adiciona bordas arredondadas em um componente UIView
    func roundCorners(cornerRadius: CGFloat, typeCorners: CACornerMask? = nil, all: Bool = false) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        if all {
            self.layer.maskedCorners = [.topLeft,
                                        .topRight,
                                        .bottomLeft,
                                        .bottomRight]
        } else {
            self.layer.maskedCorners = typeCorners ?? [.topLeft,
                                                       .topRight,
                                                       .bottomLeft,
                                                       .bottomRight]
        }
    }
    
}

extension CACornerMask {
    static public let bottomRight: CACornerMask = .layerMaxXMaxYCorner
    static public let bottomLeft: CACornerMask = .layerMinXMaxYCorner
    static public let topRight: CACornerMask = .layerMaxXMinYCorner
    static public let topLeft: CACornerMask = .layerMinXMinYCorner
}

