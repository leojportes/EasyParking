//
//  OccupyVacancyCardSectionsView.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 07/11/22.
//

import UIKit

final class OccupyVacancyCardSectionsView: CardView, ViewCodeContract {

    // MARK: - Private methods
    private let client: ClientModel

    // MARK: - Init
    init(client: ClientModel) {
        self.client = client
        super.init()
        setupView()
        backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var clientNameLabel = EFLabel("Cliente:")
    private lazy var clientNameValueLabel = EFLabel(
        client.clientName,
        font: .boldSystemFont(ofSize: 15),
        alignment: .right
    )

    private lazy var cpfClientLabel = EFLabel("CPF:")
    private lazy var cpfClientValueLabel = EFLabel(
        client.cpfClient,
        font: .boldSystemFont(ofSize: 15),
        alignment: .right
    )

    private lazy var licensePlateLabel = EFLabel("Placa:")
    private lazy var licensePlateValueLabel = EFLabel(
        client.plate,
        font: .boldSystemFont(ofSize: 15),
        alignment: .right
    )

    private lazy var modelLabel = EFLabel("Modelo:")
    private lazy var modelValueLabel = EFLabel(
        client.model,
        font: .boldSystemFont(ofSize: 15),
        alignment: .right
    )

    private lazy var colorLabel = EFLabel("Cor:")
    private lazy var colorValueLabel = EFLabel(
        client.color,
        font: .boldSystemFont(ofSize: 15),
        alignment: .right
    )

    private lazy var separatorLine1 = UIView() .. {
        $0.backgroundColor = .lightGray
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private lazy var separatorLine2 = UIView() .. {
        $0.backgroundColor = .lightGray
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private lazy var separatorLine3 = UIView() .. {
        $0.backgroundColor = .lightGray
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var separatorLine4 = UIView() .. {
        $0.backgroundColor = .lightGray
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    func setupHierarchy() {
        addSubview(clientNameLabel)
        addSubview(clientNameValueLabel)
        addSubview(separatorLine1)
        addSubview(cpfClientLabel)
        addSubview(cpfClientValueLabel)
        addSubview(separatorLine2)

        addSubview(licensePlateLabel)
        addSubview(licensePlateValueLabel)
        addSubview(separatorLine3)

        addSubview(modelLabel)
        addSubview(modelValueLabel)
        addSubview(separatorLine4)

        addSubview(colorLabel)
        addSubview(colorValueLabel)
    
    }
    
    func setupConstraints() {
        clientNameLabel
            .topAnchor(in: self, padding: 20)
            .leftAnchor(in: self, padding: 20)
            .heightAnchor(18)
            .widthAnchor(120)
        
        clientNameValueLabel
            .topAnchor(in: self, padding: 20)
            .leftAnchor(in: clientNameLabel, attribute: .right, padding: 5)
            .rightAnchor(in: self, padding: 20)
            .heightAnchor(18)
        
        separatorLine1
            .topAnchor(in: clientNameLabel, attribute: .bottom, padding: 12)
            .leftAnchor(in: self, padding: 20)
            .rightAnchor(in: self, padding: 20)
            .heightAnchor(1)
        
        cpfClientLabel
            .topAnchor(in: separatorLine1, attribute: .bottom, padding: 12)
            .leftAnchor(in: self, padding: 20)
            .heightAnchor(18)
            .widthAnchor(120)
        
        cpfClientValueLabel
            .topAnchor(in: separatorLine1, attribute: .bottom, padding: 12)
            .leftAnchor(in: cpfClientLabel, attribute: .right, padding: 5)
            .rightAnchor(in: self, padding: 20)
            .heightAnchor(18)
        
        separatorLine2
            .topAnchor(in: cpfClientLabel, attribute: .bottom, padding: 12)
            .leftAnchor(in: self, padding: 20)
            .rightAnchor(in: self, padding: 20)
            .heightAnchor(1)
    
        licensePlateLabel
            .topAnchor(in: separatorLine2, attribute: .bottom, padding: 12)
            .leftAnchor(in: self, padding: 20)
            .heightAnchor(18)
            .widthAnchor(190)
        
        licensePlateValueLabel
            .topAnchor(in: separatorLine2, attribute: .bottom, padding: 12)
            .widthAnchor(100)
            .rightAnchor(in: self, padding: 20)
            .heightAnchor(18)
        
        separatorLine3
            .topAnchor(in: licensePlateLabel, attribute: .bottom, padding: 12)
            .leftAnchor(in: self, padding: 20)
            .rightAnchor(in: self, padding: 20)
            .heightAnchor(1)
    
        modelLabel
            .topAnchor(in: separatorLine3, attribute: .bottom, padding: 12)
            .leftAnchor(in: self, padding: 20)
            .heightAnchor(18)
            .widthAnchor(120)
        
        modelValueLabel
            .topAnchor(in: separatorLine3, attribute: .bottom, padding: 12)
            .leftAnchor(in: modelLabel, attribute: .right, padding: 5)
            .rightAnchor(in: self, padding: 20)
            .heightAnchor(18)
        
        separatorLine4
            .topAnchor(in: modelLabel, attribute: .bottom, padding: 12)
            .leftAnchor(in: self, padding: 20)
            .rightAnchor(in: self, padding: 20)
            .heightAnchor(1)
        
        colorLabel
            .topAnchor(in: separatorLine4, attribute: .bottom, padding: 12)
            .leftAnchor(in: self, padding: 20)
            .heightAnchor(18)
            .widthAnchor(120)
        
        colorValueLabel
            .topAnchor(in: separatorLine4, attribute: .bottom, padding: 12)
            .rightAnchor(in: self, padding: 20)
            .heightAnchor(18)
            .bottomAnchor(in: self, padding: 20)
    }
    
}
