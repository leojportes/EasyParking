//
//  RegisterNewParkingSpaceView.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 12/11/22.
//

import UIKit

typealias CreateParkingSpaceInput = (numParkingSpace: String, status: ParkingSpaceStatus)

final class RegisterNewParkingSpaceView: UIView, ViewCodeContract {
    
    private var status: [ParkingSpaceStatus] = [.free, .inMaintenance]
    
    private var didTapRegisterNewClientButton: (CreateParkingSpaceInput) -> Void?
    private var didTapCancel: Action?
    private var shouldShowAlert: Action?
    var shouldHiddenNavigationBarAction: (Bool) -> Void = { _ in }
    
    init(
        didTapRegisterNewClientButton: @escaping (CreateParkingSpaceInput) -> Void?,
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

    private lazy var pickerView = UIPickerView() .. {
        $0.delegate = self
        $0.dataSource = self
        $0.selectRow(0, inComponent: 0, animated: true)
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
        title: "Cadastrar vaga",
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
    private lazy var titleParkingSpaceLabel = EFLabel(
        "Informações da vaga",
        font: .boldSystemFont(ofSize: 20)
    )
    
    private lazy var numParkingSpace = EFLabel("Número") .. {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .darkGray
    }
    private lazy var numParkingSpaceTF = RegisterClientTextField(
        titlePlaceholder: "ex: 1")
    
    private lazy var documentLabel = EFLabel("Status") .. {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .darkGray
    }
    
    private lazy var statusTextField = RegisterClientTextField(
        titlePlaceholder: "ex: Livre",
        keyboardType: .numberPad,
        inputView: pickerView
    )
    
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
        contentView.addSubview(titleParkingSpaceLabel)
        
        contentView.addSubview(numParkingSpace)
        contentView.addSubview(numParkingSpaceTF)
        
        contentView.addSubview(documentLabel)
        contentView.addSubview(statusTextField)

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
        
        titleParkingSpaceLabel
            .topAnchor(in: contentView, padding: 60)
            .leftAnchor(in: contentView, padding: 20)
            .rightAnchor(in: contentView, padding: 20)
            .heightAnchor(22)
        
        numParkingSpace
            .topAnchor(in: titleParkingSpaceLabel, attribute: .bottom, padding: 10)
            .leftAnchor(in: contentView, padding: 20)
            .rightAnchor(in: contentView, padding: 20)
            .heightAnchor(20)
        numParkingSpaceTF
            .topAnchor(in: numParkingSpace, attribute: .bottom, padding: 5)
            .leftAnchor(in: contentView, padding: 20)
            .rightAnchor(in: contentView, padding: 20)
            .heightAnchor(40)
        
        documentLabel
            .topAnchor(in: numParkingSpaceTF, attribute: .bottom, padding: 20)
            .leftAnchor(in: contentView, padding: 20)
            .rightAnchor(in: contentView, padding: 20)
            .heightAnchor(20)
        statusTextField
            .topAnchor(in: documentLabel, attribute: .bottom, padding: 5)
            .leftAnchor(in: contentView, padding: 20)
            .rightAnchor(in: contentView, padding: 20)
            .heightAnchor(40)
        
        spaceView
            .topAnchor(in: statusTextField, attribute: .bottom, padding: 20)
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
        let name = numParkingSpaceTF.text ?? ""
        let document = statusTextField.text ?? ""
        let someAreEmpty = name.isEmpty || document.isEmpty
        
        return someAreEmpty ? true : false
    }
    
    private func registerNewClient() {
        if isSomeEmptyField() {
            shouldShowAlert?()
        } else {
            didTapRegisterNewClientButton(
                CreateParkingSpaceInput(
                    numParkingSpaceTF.text ?? "",
                    self.setStatusToString(statusTextField.text ?? "")
                )
            )
        }
    }
    
    private func setStatusToString(_ status: String) -> ParkingSpaceStatus {
        switch status {
        case "Livre": return .free
        case "Em manutenção": return .inMaintenance
        case "Ocupado": return .busy
        default: return .free
        }
    }

    private func enumToString(status: ParkingSpaceStatus) -> String {
        switch status {
        case .free: return "Livre"
        case .busy: return "Ocupado"
        case .inMaintenance: return "Em manutenção"
        }
    }

}

// MARK: - UIPickerViewDelegate & UIPickerViewDataSource
extension RegisterNewParkingSpaceView: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return status.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return enumToString(status: status[row])
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        statusTextField.text = enumToString(status: status[row])
        statusTextField.resignFirstResponder()
    }

}
