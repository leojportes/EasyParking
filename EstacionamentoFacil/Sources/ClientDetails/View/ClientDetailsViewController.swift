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
    private var numParkingSpace: String
    // MARK: - Private properties
    private lazy var rootView = ClientDetailsView(
        client: client,
        didTapOccupyVacancyButton: { self.occupyParkingSpace() },
        didTapCancelButton: { self.viewModel.dismiss() },
        occupyVacancyTitleButton: self.numParkingSpace
    )
    
    // MARK: - Init
    init(
        _ clientModel: ClientDetailModel,
        _ numParkingSpace: String,
        viewModel: ClientDetailsViewModelProtocol,
        coordinator: CoordinatorProtocol
    ) {
        self.client = clientModel.client
        self.numParkingSpace = numParkingSpace
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .trash,
            target: self,
            action: #selector(deleteClient)
        )

    }
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    private func occupyParkingSpace() {
        // self.loadingIndicatorVisibility(show: true)
        // 2022-11-15 20:12:22 +0000
        let dateFormatter = DateFormatter()
        
        // 3.1 Portuguese Brazil Locale (pt_BR)
        let date = Date()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy HH:mm")// // set template after setting locale
        let firstDate = dateFormatter.string(from: date)
        let email = Current.shared.email
        let parkingSpace = ParkingSpace(
            _id: clientDetailModel.idParkingSpace,
            numSpace: clientDetailModel.indexParkingSpace,
            statusSpace: .busy,
            cpfClient: clientDetailModel.client.cpfClient,
            emailFirebase: email,
            firstDate: firstDate
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
    
    @objc private func deleteClient() {
        self.showAlertTwoActions(
            title: "Atenção!",
            message: "Deseja deletar este cliente?",
            leftButtonTitle: "Cancelar",
            rightButtonTitle: "Deletar"
        ) {
            self.viewModel.deleteClient(id: self.client._id) { success in
                if success {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Cliente deletado!") {
                            self.viewModel.dismiss()
                        }
                    }
                } else {
                    self.showAlert(
                        title: "Ops!",
                        message: "Tivemos algum problema ao deletar o cliente."
                    ) {
                        self.viewModel.dismiss()
                    }
                }
            }
        }
    }
    
}
