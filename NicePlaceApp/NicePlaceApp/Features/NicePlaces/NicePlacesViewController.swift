//
//  NicePlacesViewController.swift
//  NicePlaceApp
//
//  Created by Camila Luísa Farias on 22/08/22.
//

import UIKit

class NicePlacesViewController: UIViewController {
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = UIColor(named: "BackgroundColor")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 96
        tableView.separatorStyle = .none
        return tableView
    }()
    
    var nicePlaces: [PlaceModel]
    
    init(nicePlaces: [PlaceModel]) {
        self.nicePlaces = nicePlaces
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        setupTableView()
    }
}

// MARK: Setup View
extension NicePlacesViewController {
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(
            NicePlaceTableViewCell.self,
            forCellReuseIdentifier: NicePlaceTableViewCell.reuseIdentifier
        )
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension NicePlacesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nicePlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NicePlaceTableViewCell()
        cell.setupContent(place: nicePlaces[indexPath.row])
        return cell
    }
}
