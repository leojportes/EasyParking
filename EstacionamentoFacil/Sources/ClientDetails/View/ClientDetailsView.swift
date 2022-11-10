//
//  ClientDetailsView.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 09/11/22.
//

import UIKit

final class ClientDetailsView: UIView, ViewCodeContract {

    private var didTapOccupyVacancyButton: Action?
    private var didTapCancelButton: Action?
    private var client: ClientModel

    init(
        client: ClientModel,
        didTapOccupyVacancyButton: @escaping Action,
        didTapCancelButton: @escaping Action
    ) {
        self.didTapOccupyVacancyButton = didTapOccupyVacancyButton
        self.didTapCancelButton = didTapCancelButton
        self.client = client
        super.init(frame: .zero)
        setupView()
        backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var cardView = OccupyVacancyCardSectionsView(client: self.client)

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
        action: { self.didTapCancelButton?() }
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
