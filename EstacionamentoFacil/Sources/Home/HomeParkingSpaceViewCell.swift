//
//  HomeParkingSpaceViewCell.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 12/11/22.
//

import UIKit

final class HomeParkingSpaceViewCell: UICollectionViewCell, ViewCodeContract {
    
    private var parkingSpaceNum: String = ""
    
    // MARK: - Properties
    static let identifier = "HomeParkingSpaceViewCell"
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 5
        contentView.roundCorners(cornerRadius: 10)
        self.addShadow()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Viewcode
    private lazy var number = EFLabel()
    
    // MARK: - Setup viewcode
    func setupHierarchy() {
        addSubview(number)
    }
    
    func setupConstraints() {
        number.center(in: contentView)
    }
    
    func bind(number: String) {
        self.number.text = number
    }
    
    override func prepareForReuse() {
        number.text = nil
    }
}
