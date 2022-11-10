//
//  RegisterNewClientView.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 09/11/22.
//

import UIKit

final class RegisterNewClientView: UIView, ViewCodeContract {
    
    private var didTapRegisterNewClientButton: (ClientModel) -> Void?
    private var didTapCancel: Action?
    private var shouldShowAlert: Action?
    var shouldHiddenNavigationBarAction: (Bool) -> Void = { _ in }
    
    init(
        didTapRegisterNewClientButton: @escaping (ClientModel) -> Void?,
        didTapCancel: @escaping Action,
        shouldShowAlert: @escaping Action
    ) {
        self.didTapRegisterNewClientButton = didTapRegisterNewClientButton
        self.didTapCancel = didTapCancel
        self.shouldShowAlert = shouldShowAlert
        super.init(frame: .zero)
        setupView()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
         scrollView.translatesAutoresizingMaskIntoConstraints = false
         return scrollView
     }()
     
     private lazy var contentView: UIView = {
        let view = UIView()
         view.translatesAutoresizingMaskIntoConstraints = false
         return view
     }()

    private(set) lazy var registerNewClientButton = EFButton(
        title: "Cadastrar",
        colorTitle: .black,
        background: .systemGreen,
        alignmentText: .center,
        fontSize: 15,
        action: { self.registerNewClient() }
    )

    private lazy var cancelButton = EFButton(
        title: "Cancelar",
        colorTitle: .white,
        background: .systemRed,
        alignmentText: .center,
        fontSize: 15,
        action: { self.didTapCancel?() }
    )
    private lazy var clientDataLabel = EFLabel("Dados do Cliente", font: .boldSystemFont(ofSize: 20))
    private lazy var clientNameLabel = EFLabel("Nome") .. {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .darkGray
    }
    private lazy var clientNameTextField = RegisterClientTextField(titlePlaceholder: "ex: João da Silva")
    
    private lazy var documentLabel = EFLabel("CPF") .. {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .darkGray
    }
    private lazy var documentTextField = RegisterClientTextField(titlePlaceholder: "ex: 000.000.000.00")
    
    private lazy var vehicleDataLabel = EFLabel("Dados do Veículo", font: .boldSystemFont(ofSize: 20))
    private lazy var plateLabel = EFLabel("Placa") .. {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .darkGray
    }
    private lazy var plateTextField = RegisterClientTextField(titlePlaceholder: "ex: ABC1234")
    
    private lazy var modelLabel = EFLabel("Modelo") .. {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .darkGray
    }
    private lazy var modelTextField = RegisterClientTextField(titlePlaceholder: "ex: Ford Ka")
    
    private lazy var colorLabel = EFLabel("Cor") .. {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .darkGray
    }
    private lazy var colorTextField = RegisterClientTextField(titlePlaceholder: "ex: Vermelho")
    
    private lazy var spaceView = UIView() .. {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor(300)
    }
    
    private lazy var baseButtonsView = UIView() .. {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor(100)
    }
    
    
    func setupHierarchy() {
        addSubview(scrollView)
        addSubview(baseButtonsView)
        scrollView.addSubview(contentView)
        contentView.addSubview(clientDataLabel)
        contentView.addSubview(vehicleDataLabel)
        
        contentView.addSubview(clientNameLabel)
        contentView.addSubview(clientNameTextField)
        
        contentView.addSubview(documentLabel)
        contentView.addSubview(documentTextField)
        
        contentView.addSubview(plateLabel)
        contentView.addSubview(plateTextField)
        
        contentView.addSubview(modelLabel)
        contentView.addSubview(modelTextField)
        
        contentView.addSubview(colorLabel)
        contentView.addSubview(colorTextField)

        baseButtonsView.addSubview(registerNewClientButton)
        baseButtonsView.addSubview(cancelButton)
        
        contentView.addSubview(spaceView)
    }
    
    func setupConstraints() {
        scrollView
            .topAnchor(in: self)
            .leftAnchor(in: self)
            .rightAnchor(in: self)
            .bottomAnchor(in: self, layoutOption: .useSafeArea)
        
        contentView
            .pin(toEdgesOf: scrollView)
        contentView
            .widthAnchor(in: scrollView, 1)
            .heightAnchor(in: scrollView, 1, withLayoutPriorityValue: 250)
        
        clientDataLabel
            .topAnchor(in: contentView, padding: 60)
            .leftAnchor(in: contentView, padding: 20)
            .rightAnchor(in: contentView, padding: 20)
            .heightAnchor(22)
        
        clientNameLabel
            .topAnchor(in: clientDataLabel, attribute: .bottom, padding: 10)
            .leftAnchor(in: contentView, padding: 20)
            .rightAnchor(in: contentView, padding: 20)
            .heightAnchor(20)
        clientNameTextField
            .topAnchor(in: clientNameLabel, attribute: .bottom, padding: 5)
            .leftAnchor(in: contentView, padding: 20)
            .rightAnchor(in: contentView, padding: 20)
            .heightAnchor(40)
        
        documentLabel
            .topAnchor(in: clientNameTextField, attribute: .bottom, padding: 20)
            .leftAnchor(in: contentView, padding: 20)
            .rightAnchor(in: contentView, padding: 20)
            .heightAnchor(20)
        documentTextField
            .topAnchor(in: documentLabel, attribute: .bottom, padding: 5)
            .leftAnchor(in: contentView, padding: 20)
            .rightAnchor(in: contentView, padding: 20)
            .heightAnchor(40)
        
        vehicleDataLabel
            .topAnchor(in: documentTextField, attribute: .bottom, padding: 50)
            .leftAnchor(in: contentView, padding: 20)
            .rightAnchor(in: contentView, padding: 20)
            .heightAnchor(22)
        
        plateLabel
            .topAnchor(in: vehicleDataLabel, attribute: .bottom, padding: 10)
            .leftAnchor(in: contentView, padding: 20)
            .rightAnchor(in: contentView, padding: 20)
            .heightAnchor(20)
        plateTextField
            .topAnchor(in: plateLabel, attribute: .bottom, padding: 5)
            .leftAnchor(in: contentView, padding: 20)
            .rightAnchor(in: contentView, padding: 20)
            .heightAnchor(40)
        
        modelLabel
            .topAnchor(in: plateTextField, attribute: .bottom, padding: 20)
            .leftAnchor(in: contentView, padding: 20)
            .rightAnchor(in: contentView, padding: 20)
            .heightAnchor(20)
        modelTextField
            .topAnchor(in: modelLabel, attribute: .bottom, padding: 5)
            .leftAnchor(in: contentView, padding: 20)
            .rightAnchor(in: contentView, padding: 20)
            .heightAnchor(40)
        
        colorLabel
            .topAnchor(in: modelTextField, attribute: .bottom, padding: 20)
            .leftAnchor(in: contentView, padding: 20)
            .rightAnchor(in: contentView, padding: 20)
            .heightAnchor(20)
        colorTextField
            .topAnchor(in: colorLabel, attribute: .bottom, padding: 5)
            .leftAnchor(in: contentView, padding: 20)
            .rightAnchor(in: contentView, padding: 20)
            .heightAnchor(40)
        
        spaceView
            .topAnchor(in: colorTextField, attribute: .bottom, padding: 20)
            .leftAnchor(in: contentView)
            .rightAnchor(in: contentView)
            .bottomAnchor(in: contentView)
        
        baseButtonsView
            .bottomAnchor(in: self, layoutOption: .useMargins)
            .leftAnchor(in: self)
            .rightAnchor(in: self)
        
        registerNewClientButton
            .bottomAnchor(in: baseButtonsView, padding: 20)
            .leftAnchor(in: baseButtonsView, padding: 20)
            .rightAnchor(in: cancelButton, attribute: .left, padding: 15)
            .heightAnchor(50)

        cancelButton
            .bottomAnchor(in: baseButtonsView, padding: 20)
            .rightAnchor(in: baseButtonsView, padding: 20)
            .heightAnchor(50)
            .widthAnchor(150)
        
    }

    private func isSomeEmptyField() -> Bool {
        let name = clientNameTextField.text ?? ""
        let document = documentTextField.text ?? ""
        let plate = plateTextField.text ?? ""
        let model = modelTextField.text ?? ""
        let color = colorTextField.text ?? ""
        let someAreEmpty = name.isEmpty || document.isEmpty || plate.isEmpty || model.isEmpty || color.isEmpty
        
        return someAreEmpty ? true : false
    }
    
    private func registerNewClient() {
        if isSomeEmptyField() {
            shouldShowAlert?()
        } else {
            let email = Current.shared.email
            didTapRegisterNewClientButton(
                ClientModel(
                    emailFirebase: email,
                    clientName: clientNameTextField.text ?? "",
                    cpfClient: documentTextField.text ?? "",
                    plate: plateTextField.text ?? "",
                    model: modelTextField.text ?? "",
                    color: colorTextField.text ?? ""
                )
            )
        }
    }

}

class RegisterClientTextField: UITextField {
    
    private lazy var baseLineview = UIView() .. {
        $0.backgroundColor = .gray
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isHidden = true
    }
    
    init(
        titlePlaceholder: String = "",
        colorPlaceholder: UIColor = .lightGray,
        textColor: UIColor = .black,
        radius: CGFloat = 5,
        borderColor: CGColor = UIColor.darkGray.cgColor,
        borderWidth: CGFloat = 0.5,
        keyboardType: UIKeyboardType = .default,
        isSecureTextEntry: Bool = false,
        showBaseLine: Bool = false
    ) {
        super.init(frame: .zero)
        self.attributedPlaceholder = NSAttributedString(
            string: titlePlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: colorPlaceholder]
        )
        self.textColor = textColor
        self.layer.cornerRadius = radius
        self.layer.borderColor = borderColor
        self.layer.borderWidth = borderWidth
        self.translatesAutoresizingMaskIntoConstraints = false
        self.keyboardType = keyboardType
        self.isSecureTextEntry = isSecureTextEntry
        self.setPaddingLeft()
        
        self.addSubview(baseLineview)
        baseLineview
            .bottomAnchor(in: self)
            .heightAnchor(1)
            .leftAnchor(in: self)
            .rightAnchor(in: self)
        
        baseLineview.isHidden = !showBaseLine
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
