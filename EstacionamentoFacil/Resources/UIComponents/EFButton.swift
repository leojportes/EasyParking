//
//  EFButton.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 24/10/22.
//

import UIKit

class EFButton: UIButton {
    private var action: Action?
    
    init(title: String,
         colorTitle: UIColor = .darkGray,
         radius: Int = 0,
         background: UIColor = .clear,
         alignmentText: ContentHorizontalAlignment = .center,
         borderColorCustom: CGColor = UIColor.clear.cgColor,
         borderWidthCustom: CGFloat = CGFloat(),
         fontSize: CGFloat = 18,
         action: @escaping Action = {}
    ) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(colorTitle, for: .normal)
        self.layer.cornerRadius = 10
        self.backgroundColor = background
        self.contentHorizontalAlignment = alignmentText
        self.layer.borderColor = borderColorCustom
        self.layer.borderWidth = borderWidthCustom
        self.titleLabel?.font = .boldSystemFont(ofSize: fontSize)
        self.action = action
        self.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func didTap() {
        action?()
    }
    
}

class EFParkingSpaceButton: UIButton {
    private var action: Action?
    
    init(title: String,
         colorTitle: UIColor = .darkGray,
         radius: Int = 0,
         background: UIColor = .clear,
         alignmentText: ContentHorizontalAlignment = .center,
         borderColorCustom: CGColor = UIColor.clear.cgColor,
         borderWidthCustom: CGFloat = CGFloat(),
         fontSize: CGFloat = 18,
         action: @escaping Action = {}
    ) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(colorTitle, for: .normal)
        self.layer.cornerRadius = 10
        self.backgroundColor = background
        self.contentHorizontalAlignment = alignmentText
        self.layer.borderColor = borderColorCustom
        self.layer.borderWidth = borderWidthCustom
        self.titleLabel?.font = .boldSystemFont(ofSize: fontSize)
        self.action = action
        self.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor(100)
        self.widthAnchor(100)
        self.addShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func didTap() {
        action?()
    }
    
}
