//
//  LoginView.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 24/10/22.
//

import UIKit

final class LoginView: UIView, ViewCodeContract {
    
    private let didTapLogin: (String, String) -> Void?
    private let didTapCreateAccount: Action?

    init(
        didTapLogin: @escaping (String, String) -> Void,
        didTapCreateAccount: @escaping Action
    ) {
        self.didTapLogin = didTapLogin
        self.didTapCreateAccount = didTapCreateAccount
        super.init(frame: .zero)
        setupView()
        backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var emailTextField: EFTextField = {
        let textField = EFTextField(
            titlePlaceholder: "e-mail cadastrado",
            colorPlaceholder: .lightGray,
            textColor: .black,
            radius: 5,
            borderColor: UIColor.darkGray.cgColor,
            borderWidth: 0.5,
            keyboardType: .emailAddress
        )
        textField.autocapitalizationType = .none
        textField.clearButtonMode = .whileEditing
        textField.addTarget(self, action: #selector(textFieldEditingDidChange), for: .editingChanged)
        return textField
    }()
    
    private lazy var passwordTextField: EFTextField = {
        let textField = EFTextField(
            titlePlaceholder: "senha",
            colorPlaceholder: .lightGray,
            textColor: .black,
            radius: 5,
            borderColor: UIColor.darkGray.cgColor,
            borderWidth: 0.5,
            isSecureTextEntry: true
        )
        textField.autocapitalizationType = .none
        textField.addTarget(self, action: #selector(textFieldEditingDidChange), for: .editingChanged)
        return textField
    }()
    
    lazy var loginButton: EFButton = {
        let button = EFButton(
            title: "Login",
            colorTitle: .black,
            radius: 10,
            background: .lightGray
        )
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
        return button
    }()

    private lazy var titleLabel = UILabel() .. {
        $0.font = .boldSystemFont(ofSize: 23)
        $0.text = "Estacionamento Fácil"
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    lazy var createAccount: EFButton = {
        let button = EFButton(
            title: "Criar conta",
            colorTitle: .black,
            radius: 10,
            background: .systemGray
        )
        button.addTarget(self, action: #selector(createAccountAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var parkingImageView = UIImageView() .. {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "img_parking")
    }

    @objc
    func createAccountAction() {
        didTapCreateAccount?()
    }

    // MARK: - Setup methods
    func setupHierarchy() {
        addSubview(parkingImageView)
        addSubview(titleLabel)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(createAccount)
    }
    
    func setupConstraints() {
        
        parkingImageView
            .topAnchor(in: self, padding: 20)
            .widthAnchor(100)
            .heightAnchor(100)
            .centerX(in: self)
        
        titleLabel
            .topAnchor(in: parkingImageView, attribute: .bottom, padding: 20)
            .centerX(in: parkingImageView)
            .heightAnchor(25)
        
        emailTextField
            .topAnchor(in: titleLabel, attribute: .bottom, padding: 30)
            .leftAnchor(in: self, attribute: .left, padding: 16)
            .rightAnchor(in: self, attribute: .right, padding: 16)
            .heightAnchor(48)
        
        passwordTextField
            .topAnchor(in: emailTextField, attribute: .bottom, padding: 17)
            .leftAnchor(in: self, attribute: .left, padding: 16)
            .rightAnchor(in: self, attribute: .right, padding: 16)
            .heightAnchor(48)
        
        loginButton
            .topAnchor(in: passwordTextField, attribute: .bottom, padding: 26)
            .leftAnchor(in: self, attribute: .left, padding: 16)
            .rightAnchor(in: self, attribute: .right, padding: 16)
            .heightAnchor(48)
        
        createAccount
            .topAnchor(in: loginButton, attribute: .bottom, padding: 20)
            .leftAnchor(in: self, attribute: .left, padding: 16)
            .rightAnchor(in: self, attribute: .right, padding: 16)
            .heightAnchor(48)
    }

    func setupConfiguration() {
        self.backgroundColor = UIColor(named: "separatorGray")
    }
    
    private func isEnabledButtonLogin(_ isEnabled: Bool) {
        if isEnabled {
            loginButton.backgroundColor = .systemGreen
            loginButton.isEnabled = true
        } else {
            loginButton.backgroundColor = .lightGray
            loginButton.isEnabled = false
        }
    }
    
    // MARK: - Action TextFields
    @objc private func textFieldEditingDidChange() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        let isValidLogin = email.isValidEmail() && password.count >= 7
        isValidLogin ? isEnabledButtonLogin(true) : isEnabledButtonLogin(false)
    }

    @objc
    private func handleLoginButton() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        didTapLogin(email, password)
    }
}
