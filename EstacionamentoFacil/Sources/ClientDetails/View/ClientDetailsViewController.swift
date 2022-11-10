//
//  ClientDetailsViewController.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 09/11/22.
//

public struct ClientDetailModel {
    let client: ClientModel
    let indexParkingSpace: String
    let idParkingSpace: String
}

import UIKit
import FirebaseAuth

class ClientDetailsViewController: CoordinatedViewController {
    
    private var client: ClientModel
    private var viewModel: ClientDetailsViewModelProtocol
    private var clientDetailModel: ClientDetailModel
    // MARK: - Private properties
    private lazy var rootView = ClientDetailsView(
        client: client,
        didTapOccupyVacancyButton: { self.occupyParkingSpace() },
        didTapCancelButton: { self.viewModel.dismiss() }
    )
    
    // MARK: - Init
    init(_ clientModel: ClientDetailModel, viewModel: ClientDetailsViewModelProtocol, coordinator: CoordinatorProtocol) {
        self.client = clientModel.client
        self.clientDetailModel = clientModel
        self.viewModel = viewModel
        super.init(coordinator: coordinator)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detalhes do cliente"
    }
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    private func occupyParkingSpace() {
        // self.loadingIndicatorVisibility(show: true)
        let email = Current.shared.email
        let parkingSpace = ParkingSpace(
            _id: clientDetailModel.idParkingSpace,
            numSpace: clientDetailModel.indexParkingSpace,
            statusSpace: .busy,
            cpfClient: clientDetailModel.client.cpfClient,
            emailFirebase: email
        )
        
        self.viewModel.occupyParkingSpace(
            parkingSpace: parkingSpace,
            id: clientDetailModel.idParkingSpace
        ) { success in
            if success {
                // self.loadingIndicatorVisibility(show: false)
                DispatchQueue.main.async {
                    self.showAlert(title: "Pronto!", message: "Vaga ocupada com sucesso!") {
                        self.viewModel.popToHome()
                    }
                }
            } else {
                // self.loadingIndicatorVisibility(show: false)
                DispatchQueue.main.async {
                    self.showAlert(title: "Ops!", message: "Tivemos algum problema, tente novamente.")
                }
            }
        }
    }
    
}
