//
//  OccupyVacancyView.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 07/11/22.
//

import UIKit

final class OccupyVacancyView: UIView, ViewCodeContract {
    
    private var didTapRegisterClientButton: Action?
    private var didTapClient: (ClientModel) -> Void?

    var clientItems: [ClientModel] = [] {
        didSet {
            tableview.reloadData()
        }
    }

    init(
        didTapRegisterClientButton: @escaping Action,
        didTapClient: @escaping (ClientModel) -> Void?
    ) {
        self.didTapRegisterClientButton = didTapRegisterClientButton
        self.didTapClient = didTapClient
        super.init(frame: .zero)
        setupView()
        backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var registerButton = EFButton(
        title: "Cadastrar novo cliente",
        colorTitle: .black,
        background: .systemGreen,
        alignmentText: .center,
        fontSize: 15,
        action: { self.didTapRegisterClientButton?() }
    ) .. {
        $0.isHidden = false
    }

    private lazy var baseButtonView = UIView() .. {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isHidden = false
    }

    lazy var tableview: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(OccupyVacancyViewCell.self, forCellReuseIdentifier: OccupyVacancyViewCell.identifier)
        table.register(EFErrorTableViewCell.self, forCellReuseIdentifier: EFErrorTableViewCell.identifier)
//        table.refreshControl = UIRefreshControl()
//        table.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        table.separatorStyle = .none
        table.backgroundColor = .white
        table.delegate = self
        table.dataSource = self
        return table
    }()

    func setupHierarchy() {
        addSubview(tableview)
        addSubview(baseButtonView)
        baseButtonView.addSubview(registerButton)
    }
    
    func setupConstraints() {
        tableview
            .topAnchor(in: self, padding: 10)
            .leftAnchor(in: self)
            .rightAnchor(in: self)
            .bottomAnchor(in: self, layoutOption: .useMargins)
        
        baseButtonView
            .bottomAnchor(in: self, layoutOption: .useMargins)
            .leftAnchor(in: self)
            .rightAnchor(in: self)
            .heightAnchor(100)
        registerButton
            .topAnchor(in: baseButtonView, padding: 20)
            .leftAnchor(in: baseButtonView, padding: 20)
            .rightAnchor(in: baseButtonView, padding: 20)
            .heightAnchor(50)
    }
    
}

extension OccupyVacancyView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if clientItems.isEmpty { return 1 }
        return clientItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if clientItems.isEmpty {
            let cellEmpty = tableview
                .dequeueReusableCell(withIdentifier: EFErrorTableViewCell.identifier, for: indexPath) as? EFErrorTableViewCell

            cellEmpty?.isUserInteractionEnabled = false
            
            return cellEmpty ?? UITableViewCell()
        } else {
            let cell = tableview
                .dequeueReusableCell(withIdentifier: OccupyVacancyViewCell.identifier, for: indexPath) as? OccupyVacancyViewCell
            
            let client = clientItems[indexPath.row]
            cell?.setupCustomCell(plate: client.plate, clientName: client.clientName, model: client.model, color: client.color)

            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if clientItems.isEmpty == false {
            let client = clientItems[indexPath.row]
            didTapClient(client)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}
