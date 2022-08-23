//
//  FindNicePlaceViewController.swift
//  NicePlaceApp
//
//  Created by Camila Luísa Farias on 21/08/22.
//

import UIKit

class FindNicePlaceViewController: UIViewController {
    
    let contentSearchView: UIView = {
       let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Find nice places"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Seach", for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var viewModel: FindNicePlaceViewModelProtocol
    
    init(viewModel: FindNicePlaceViewModelProtocol = FindNicePlaceViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        viewModel.delegate = self
    }
}

// MARK: Setup View
extension FindNicePlaceViewController {
    private func setupView() {
        view.backgroundColor = .brown
        
        setupSeachTextField()
        setupSeachButton()
        setupTableView()
    }
    
    private func setupSeachTextField() {
        view.addSubview(contentSearchView)
        
        NSLayoutConstraint.activate([
            contentSearchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentSearchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentSearchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentSearchView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        contentSearchView.addSubview(searchTextField)
        
        NSLayoutConstraint.activate([
            searchTextField.centerYAnchor.constraint(equalTo: contentSearchView.centerYAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: contentSearchView.leadingAnchor, constant: 8),
            searchTextField.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func setupSeachButton() {
        contentSearchView.addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            searchButton.centerYAnchor.constraint(equalTo: contentSearchView.centerYAnchor),
            searchButton.leadingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: 8),
            searchButton.trailingAnchor.constraint(equalTo: contentSearchView.trailingAnchor, constant: -8),
            searchButton.heightAnchor.constraint(equalToConstant: 24),
            searchButton.widthAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: contentSearchView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension FindNicePlaceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - FindNicePlaceViewModelDelegate
extension FindNicePlaceViewController: FindNicePlaceViewModelDelegate {
    func getPlaces(places: [PlaceModel]) {
        // TO DO
    }
    
    func showError() {
        // TO DO
    }
    
    func showLoading() {
        // TO DO
    }
}
