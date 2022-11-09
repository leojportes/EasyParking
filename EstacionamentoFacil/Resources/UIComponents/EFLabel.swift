//
//  EFLabel.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 07/11/22.
//

import UIKit

class EFLabel: UILabel {

    init(
        _ text: String = "",
        font: UIFont = .boldSystemFont(ofSize: 18),
        alignment: NSTextAlignment = .left
    ) {
        super.init(frame: .zero)
        self.text = text
        self.font = font
        textAlignment = alignment
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
