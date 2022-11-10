//
//  RegisterNewClientViewController.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 09/11/22.
//

import UIKit

class RegisterNewClientViewController: CoordinatedViewController {
    
    var shouldHiddenNavigationBar: (Bool) -> Void = { _ in }

    // MARK: - Private properties
    private var viewModel: RegisterNewClientViewModelProtocol
    private lazy var rootView = RegisterNewClientView(
        didTapRegisterNewClientButton: { client in
            self.loadingIndicatorVisibility(show: true)
            self.viewModel.createNewClient(client: client) { success in
                if success {
                    self.loadingIndicatorVisibility(show: false)
                    self.showAlert(title: "Pronto!", message: "Cliente cadastrado com sucesso!") {
                        self.viewModel.dismiss()
                    }
                    print("Cadastrado")
                } else {
                    self.loadingIndicatorVisibility(show: false)
                    self.showAlert(title: "Ops!", message: "Tivemos algum problema, tente novamente.")
                }
            }
        },
        didTapCancel: { self.viewModel.dismiss() },
        shouldShowAlert: { self.showAlert(title: "Ops!", message: "Há campos em branco.") }
    )
    
    func loadingIndicatorVisibility(show: Bool) {
        rootView.registerNewClientButton.loadingIndicator(show: show)
    }

    // MARK: - Init
    init(viewModel: RegisterNewClientViewModelProtocol, coordinator: CoordinatorProtocol) {
        self.viewModel = viewModel
        super.init(coordinator: coordinator)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cadastrar novo cliente"
        hideKeyboardWhenTappedAround()
        
    }
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
}
