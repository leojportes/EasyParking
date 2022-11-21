//
//  HomeView.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 02/11/22.
//

import UIKit

final class HomeViewV2: UIView, ViewCodeContract {
    
    private var buttonAction: (ParkingSpace) -> Void?
    private var didTapCrateParkingSpace: Action?
    
    var parkingSpaces: [ParkingSpace] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    init(
        didTapButton: @escaping (ParkingSpace) -> Void?,
        didTapCrateParkingSpace: @escaping Action
    ) {
        self.buttonAction = didTapButton
        self.didTapCrateParkingSpace = didTapCrateParkingSpace
        super.init(frame: .zero)
        setupView()
        backgroundColor = UIColor(named: "separatorGray")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var iconView: UIView = {
        let container = UIView()
        container.backgroundColor = .lightGray
        container.roundCorners(cornerRadius: 25)
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()

    private lazy var firstNameLabel = EFLabel(
        Current.shared.email.prefix(1).uppercased(),
        font: UIFont.boldSystemFont(ofSize: 20)
    )

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 100, height: 100)
        let collection = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collection.register(
            HomeParkingSpaceViewCell.self,
            forCellWithReuseIdentifier: HomeParkingSpaceViewCell.identifier
        )
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor(named: "separatorGray")
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private lazy var emptyView = ErrorView(
        title: "Nenhuma vaga encontrada!",
        subTitle: "Cadastre uma vaga para seu estacionamento.",
        imageName: "icon-alert-error"
    ) .. {
        $0.isHidden = true
    }
    
    func setupHierarchy() {
        addSubview(iconView)
        addSubview(emptyView)
        iconView.addSubview(firstNameLabel)
        addSubview(usernameLabel)
        addSubview(collectionView)
    }

    func setupConstraints() {
        iconView
            .topAnchor(in: self, padding: 30)
            .leftAnchor(in: self, padding: 20)
            .heightAnchor(50)
            .widthAnchor(50)
        
        usernameLabel
            .centerY(in: iconView)
            .leftAnchor(in: iconView, attribute: .right, padding: 15)
            .heightAnchor(30)
        
        firstNameLabel
            .centerX(in: iconView)
            .centerY(in: iconView)
        
        emptyView
            .topAnchor(in: self, padding: 130)
            .leftAnchor(in: self, padding: 20)
            .rightAnchor(in: self, padding: 20)
            .bottomAnchor(in: self, layoutOption: .useMargins)
        
        collectionView
            .topAnchor(in: self, padding: 130)
            .leftAnchor(in: self, padding: 20)
            .rightAnchor(in: self, padding: 20)
            .bottomAnchor(in: self, layoutOption: .useMargins)
    }
    
    private lazy var usernameLabel = UILabel() .. {
        $0.text = Current.shared.email
        $0.font = .systemFont(ofSize: 18)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    @objc private func didTapCreateParkingSpace() {
        didTapCrateParkingSpace?()
    }

    func shouldDisplayEmptyView(_ show: Bool = false) {
        self.emptyView.isHidden = !show
        self.collectionView.isHidden = show
    }
}

extension HomeViewV2: UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parkingSpaces.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeParkingSpaceViewCell.identifier, for: indexPath) as? HomeParkingSpaceViewCell else { return UICollectionViewCell() }
        let item = parkingSpaces[indexPath.row]
        cell.contentView.backgroundColor = setColor(item.statusSpace)
        cell.bind(number: item.numSpace)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = parkingSpaces[indexPath.row]
        self.buttonAction(item)
    }
    
    private func setColor(_ status: ParkingSpaceStatus) -> UIColor {
        switch status {
        case .free: return .systemGreen
        case .busy: return .systemYellow
        case .inMaintenance: return .systemRed
        }
    }

}
