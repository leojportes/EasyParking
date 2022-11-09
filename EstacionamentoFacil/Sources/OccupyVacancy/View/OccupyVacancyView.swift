//
//  OccupyVacancyView.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 07/11/22.
//

import UIKit

final class OccupyVacancyView: UIView, ViewCodeContract {
    
    private var didTapOccupyVacancyButton: Action?
    private var didTapCancelButton: Action?

    init(
        didTapOccupyVacancyButton: @escaping Action,
        didTapCancelButton: @escaping Action
    ) {
        self.didTapOccupyVacancyButton = didTapOccupyVacancyButton
        self.didTapCancelButton = didTapCancelButton
        super.init(frame: .zero)
        setupView()
        backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var cardView = OccupyVacancyCardSectionsView(
        clientName: "Leonardo Portes",
        cpfClient: "08547733382",
        licensePlate: "QAG3304",
        model: "Ford Ka",
        color: "Vermelho"
    )

    private lazy var occupyVacancyButton = EFButton(
        title: "Ocupar vaga",
        colorTitle: .black,
        background: .systemGreen,
        alignmentText: .center,
        fontSize: 15,
        action: { self.didTapOccupyVacancyButton?() }
    )

    private lazy var cancelButton = EFButton(
        title: "Cancelar",
        colorTitle: .white,
        background: .systemRed,
        alignmentText: .center,
        fontSize: 15,
        action: {
            self.didTapCancelButton?()
        }
    )


    func setupHierarchy() {
        addSubview(cardView)
        addSubview(occupyVacancyButton)
        addSubview(cancelButton)
    }
    
    func setupConstraints() {
        cardView
            .topAnchor(in: self, padding: 60)
            .rightAnchor(in: self, padding: 10)
            .leftAnchor(in: self, padding: 10)
            
        occupyVacancyButton
            .bottomAnchor(in: self, padding: 40)
            .leftAnchor(in: self, padding: 20)
            .rightAnchor(in: cancelButton, attribute: .left, padding: 15)
            .heightAnchor(50)

        cancelButton
            .bottomAnchor(in: self, padding: 40)
            .rightAnchor(in: self, padding: 20)
            .heightAnchor(50)
            .widthAnchor(150)
    }
    
}

class CardView: UIView {
    
    init(
        shadowColor: CGColor = UIColor.black.cgColor,
        shadowOpacity: Float = 0.3,
        shadowOffset: CGSize = CGSize(width: 0.0, height: 1),
        shadowRadius: CGFloat = 2,
        cornerRadius: CGFloat = 10,
        backgroundColor: UIColor = .lightGray
    ) {
        super.init(frame: .zero)
        self.layer.shadowColor = shadowColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.layer.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
