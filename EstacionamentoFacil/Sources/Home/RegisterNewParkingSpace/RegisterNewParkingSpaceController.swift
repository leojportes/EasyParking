//
//  RegisterNewParkingSpaceController.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 12/11/22.
//

import UIKit
import FirebaseAuth

class RegisterNewParkingSpaceController: CoordinatedViewController {

    // MARK: - Private properties
    private let viewModel: RegisterNewParkingSpaceViewModelProtocol
    private var parkingSpaces: [ParkingSpace] = []
    
    private lazy var rootView = RegisterNewParkingSpaceView(
        didTapRegisterNewClientButton: { num, status in
            self.createNewParkingSpace(inputs: (num, status))
        },
        didTapCancel: { self.viewModel.dismiss() },
        shouldShowAlert: { self.showAlert(title: "Ops!", message: "Há campos em branco.") }
    )

    // MARK: - Init
    init(parkingSpaces: [ParkingSpace], viewModel: RegisterNewParkingSpaceViewModelProtocol, coordinator: CoordinatorProtocol) {
        self.viewModel = viewModel
        self.parkingSpaces = parkingSpaces
        super.init(coordinator: coordinator)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Adicionar vaga"
        hideKeyboardWhenTappedAround()
    }

    override func loadView() {
        super.loadView()
        view = rootView
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    private func createNewParkingSpace(inputs: CreateParkingSpaceInput) {
        let doesNotExistParkingSpace = self.parkingSpaces.filter { $0.numSpace == inputs.numParkingSpace }.isEmpty
        
        if doesNotExistParkingSpace {
            let email = Current.shared.email
            let item = CreateParkingSpace(
                numSpace: inputs.numParkingSpace,
                statusSpace: inputs.status,
                cpfClient: "",
                emailFirebase: email,
                firstDate: ""
            )
            viewModel.createNew(parkingSpacing: item) { success in
                DispatchQueue.main.async {
                    self.viewModel.dismiss()
                }
            }
        } else {
            self.showAlert(title: "Esta vaga já existe!", message: "Escolha outro número para a vaga.")
        }
        
    }

}
