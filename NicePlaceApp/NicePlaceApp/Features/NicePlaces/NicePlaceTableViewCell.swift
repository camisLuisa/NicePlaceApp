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
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var placeName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
    }
}

extension NicePlaceTableViewCell {
    private func setupView() {
        setupContainerView()
        setupPlaceName()
    }
    
    private func setupContainerView() {
        contentView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func setupPlaceName() {
        containerView.addSubview(placeName)
        
        NSLayoutConstraint.activate([
            placeName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            placeName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        ])
    }
}
