//
//  NicePlaceTableViewCell.swift
//  NicePlaceApp
//
//  Created by Camila Luísa Farias on 22/08/22.
//

import UIKit

class NicePlaceTableViewCell: UITableViewCell {
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "CustomBackground")
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var placeName: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var placeAddress: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContent(place: PlaceModel) {
        placeName.text = place.name
        placeAddress.text = place.address
    }
}

extension NicePlaceTableViewCell {
    private func setupView() {
        backgroundColor = .clear
        setupContainerView()
        setupPlaceName()
        setupPlaceAddress()
    }
    
    private func setupContainerView() {
        contentView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    private func setupPlaceName() {
        containerView.addSubview(placeName)
        
        NSLayoutConstraint.activate([
            placeName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            placeName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            placeName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    private func setupPlaceAddress() {
        containerView.addSubview(placeAddress)

        NSLayoutConstraint.activate([
            placeAddress.topAnchor.constraint(equalTo: placeName.bottomAnchor, constant: 8),
            placeAddress.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            placeAddress.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}
