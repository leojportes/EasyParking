//
//  HomeView.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 02/11/22.
//

import UIKit

final class HomeView: UIView, ViewCodeContract {
    
    private var buttonAction: (ButtonID) -> Void?

    init(didTapButton: @escaping (ButtonID) -> Void?) {
        self.buttonAction = didTapButton
        super.init(frame: .zero)
        setupView()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var iconView: UIView = {
        let container = UIView()
        container.backgroundColor = .lightGray
        container.roundCorners(cornerRadius: 25)
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private lazy var firstNameLabel = EFLabel(
        Current.shared.email.prefix(1).uppercased(),
        font: UIFont.boldSystemFont(ofSize: 20)
    )
    
    func setupHierarchy() {
        addSubview(iconView)
        iconView.addSubview(firstNameLabel)
        
        addSubview(usernameLabel)
        
        // First row of buttons
        addSubview(firstButton)
        addSubview(secondButton)
        addSubview(thirdButton)
        
        // Second row of buttons
        addSubview(fourthButton)
        addSubview(fifthButton)
        addSubview(sixthButton)
        
        // Third row of buttons
        addSubview(seventhButton)
        addSubview(eighthButton)
        addSubview(ninthButton)
    }

    func setupConstraints() {
        
        iconView
            .topAnchor(in: self, padding: 30)
            .leftAnchor(in: self, padding: 20)
            .heightAnchor(50)
            .widthAnchor(50)
        
        usernameLabel
            .centerY(in: iconView)
            .leftAnchor(in: iconView, attribute: .right, padding: 15)
            .heightAnchor(30)
        
        firstNameLabel
            .centerX(in: iconView)
            .centerY(in: iconView)
        
        // First row of buttons
        firstButton
            .topAnchor(in: iconView, attribute: .bottom, padding: 70)
            .leftAnchor(in: self, padding: 34)
        secondButton
            .topAnchor(in: iconView, attribute: .bottom, padding: 70)
            .leftAnchor(in: firstButton, attribute: .right, padding: 10)
        thirdButton
            .topAnchor(in: iconView, attribute: .bottom, padding: 70)
            .leftAnchor(in: secondButton, attribute: .right, padding: 10)

        // Second row of buttons
        fourthButton
            .topAnchor(in: firstButton, attribute: .bottom, padding: 20)
            .leftAnchor(in: self, padding: 34)
        fifthButton
            .topAnchor(in: secondButton, attribute: .bottom, padding: 20)
            .leftAnchor(in: firstButton, attribute: .right, padding: 10)
        sixthButton
            .topAnchor(in: thirdButton, attribute: .bottom, padding: 20)
            .leftAnchor(in: secondButton, attribute: .right, padding: 10)
        
        // Third row of buttons
        seventhButton
            .topAnchor(in: fourthButton, attribute: .bottom, padding: 20)
            .leftAnchor(in: self, padding: 34)
        eighthButton
            .topAnchor(in: fifthButton, attribute: .bottom, padding: 20)
            .leftAnchor(in: seventhButton, attribute: .right, padding: 10)
        ninthButton
            .topAnchor(in: sixthButton, attribute: .bottom, padding: 20)
            .leftAnchor(in: eighthButton, attribute: .right, padding: 10)
    }
    
    private lazy var usernameLabel = UILabel() .. {
        $0.text = Current.shared.email
        $0.font = .systemFont(ofSize: 18)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    // First row of buttons
    private lazy var firstButton = EFParkingSpaceButton(
        title: "Vaga 1",
        background: .systemGreen,
        action: { self.buttonAction(.firstBtn) }
    )
    private lazy var secondButton = EFParkingSpaceButton(
        title: "Vaga 2",
        background: .systemGreen,
        action: { self.buttonAction(.secondBtn) }
    )
    private lazy var thirdButton = EFParkingSpaceButton(
        title: "Vaga 3",
        background: .systemGreen,
        action: { self.buttonAction(.thirdBtn) }
    )
    
    // Second row of buttons
    private lazy var fourthButton = EFParkingSpaceButton(
        title: "Vaga 4",
        background: .systemGreen,
        action: { self.buttonAction(.fourthBtn) }
    )
    private lazy var fifthButton = EFParkingSpaceButton(
        title: "Vaga 5",
        background: .systemGreen,
        action: { self.buttonAction(.fifthBtn) }
    )
    private lazy var sixthButton = EFParkingSpaceButton(
        title: "Vaga 6",
        background: .systemGreen,
        action: { self.buttonAction(.sixthBtn) }
    )
    
    // Third row of buttons
    private lazy var seventhButton = EFParkingSpaceButton(
        title: "Vaga 7",
        background: .systemGreen,
        action: { self.buttonAction(.seventhBtn) }
    )
    private lazy var eighthButton = EFParkingSpaceButton(
        title: "Vaga 8",
        background: .systemGreen,
        action: { self.buttonAction(.eighthBtn) }
    )
    private lazy var ninthButton = EFParkingSpaceButton(
        title: "Vaga 9",
        background: .systemGreen,
        action: { self.buttonAction(.ninthBtn) }
    )

    func setFirstColor(_ first: UIColor) {
        self.firstButton.backgroundColor = first
    }

    func setSecondColor(_ second: UIColor) {
        self.secondButton.backgroundColor = second
    }
    
    func setThirdColor(_ third: UIColor) {
        self.thirdButton.backgroundColor = third
    }
    
    func setFourthColor(_ fourth: UIColor) {
        self.fourthButton.backgroundColor = fourth
    }
    
    func setFifthColor(_ fifth: UIColor) {
        self.fifthButton.backgroundColor = fifth
    }

    func setSixthColor(_ sixth: UIColor) {
        self.sixthButton.backgroundColor = sixth
    }
    
    func setSeventhColor(_ seventh: UIColor) {
        self.seventhButton.backgroundColor = seventh
    }
    
    func setEighthColor(_ eighth: UIColor) {
        self.eighthButton.backgroundColor = eighth
    }
    
    func setNinthColor(_ ninth: UIColor) {
        self.ninthButton.backgroundColor = ninth
    }

}
