//
//  EFErrorTableViewCell.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 09/11/22.
//

import UIKit

final class EFErrorTableViewCell: UITableViewCell, ViewCodeContract {
    
    // MARK: - Static properties
    static let identifier = "EFErrorTableViewCell"
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var emptyView: ErrorView = {
        let view = ErrorView(
            title: "Nenhuma placa encontrada!",
            subTitle: "Cadastre um novo cliente com esta placa.",
            imageName: "icon-alert-error"
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    // MARK: - Setup view
    func setupHierarchy() {
        contentView.addSubview(emptyView)
    }

    func setupConstraints() {
        emptyView
            .topAnchor(in: contentView, attribute: .top, padding: 40)
            .leftAnchor(in: contentView)
            .rightAnchor(in: contentView)
            .bottomAnchor(in: contentView)
    }
    
    func setupConfiguration() {
        selectionStyle = .none
    }

}
