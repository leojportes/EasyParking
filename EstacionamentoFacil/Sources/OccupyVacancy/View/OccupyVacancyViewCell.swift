//
//  OccupyVacancyViewCell.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 10/11/22.
//

import UIKit

final class OccupyVacancyViewCell: UITableViewCell, ViewCodeContract {
    
    // MARK: - Static properties
    static let identifier = "OccupyVacancyViewCell"
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    // MARK: - Viewcode

    private lazy var plateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = UIColor(named: "grayDarkest")
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var clientNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor(named: "grayDescription")
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var modelLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = UIColor(named: "grayDarkest")
        label.numberOfLines = .zero
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var colorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = UIColor(named: "grayDescription")
        label.numberOfLines = 1
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var icon = UIImageView() .. {
        $0.image = UIImage(named: "ic_plate")
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    lazy var separatorLine = UIView() .. {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .lightGray
        $0.heightAnchor(1)
    }
    
    // MARK: - Viewcode methods
    func setupHierarchy() {
        contentView.addSubview(backView)
        backView.addSubview(icon)
        backView.addSubview(plateLabel)
        backView.addSubview(clientNameLabel)
        backView.addSubview(modelLabel)
        backView.addSubview(colorLabel)
        backView.addSubview(separatorLine)
    }
    
    func setupConstraints() {
        contentView
            .topAnchor(in: self, padding: 5)
            .bottomAnchor(in: self, padding: 5)
        
        backView
            .topAnchor(in: contentView)
            .leftAnchor(in: contentView)
            .rightAnchor(in: contentView)
            .bottomAnchor(in: contentView)
    
        icon
            .centerY(in: backView)
            .leftAnchor(in: backView, padding: 23)
            .widthAnchor(30)
            .heightAnchor(30)
        
        plateLabel
            .topAnchor(in: backView, padding: 20)
            .leftAnchor(in: icon, attribute: .right, padding: 15)
            .widthAnchor(150)
        
        clientNameLabel
            .topAnchor(in: plateLabel, attribute: .bottom, padding: 4)
            .leftAnchor(in: icon, attribute: .right, padding: 15)
            .widthAnchor(130)
        
        modelLabel
            .topAnchor(in: backView, padding: 20)
            .leftAnchor(in: clientNameLabel, attribute: .right, padding: 10)
            .rightAnchor(in: backView, padding: 20)
        
        colorLabel
            .topAnchor(in: modelLabel, attribute: .bottom, padding: 5)
            .rightAnchor(in: backView, padding: 20)
            .leftAnchor(in: clientNameLabel, attribute: .right, padding: 5)
        
        separatorLine
            .topAnchor(in: colorLabel, attribute: .bottom, padding: 18)
            .rightAnchor(in: backView)
            .leftAnchor(in: backView)

    }
    
    func setupConfiguration() {
        selectionStyle = .none
    }
    
    // MARK: - Public methods
    func setupCustomCell(
        plate: String? = nil,
        clientName: String? = nil,
        model: String? = nil,
        color: String? = nil
    ) {
        plateLabel.text = plate
        clientNameLabel.text = clientName
        modelLabel.text = model
        colorLabel.text = color
    }

}
