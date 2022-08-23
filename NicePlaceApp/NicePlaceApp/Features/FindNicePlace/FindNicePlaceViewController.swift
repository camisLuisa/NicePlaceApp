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
    
    lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Seach", for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(searchButtonAction), for: .touchUpInside)
        return button
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

// MARK: Private methods
extension FindNicePlaceViewController {
    @objc
    private func searchButtonAction() {
        if let placeCategory = searchTextField.text, searchTextField.text != "" {
            viewModel.findPlaces(with: placeCategory, latitude: -8.1117522, longitude: -34.8922874)
        }
    }
}

// MARK: Setup View
extension FindNicePlaceViewController {
    private func setupView() {
        view.backgroundColor = .brown
        
        setupSeachTextField()
        setupSeachButton()
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
}

// MARK: - FindNicePlaceViewModelDelegate
extension FindNicePlaceViewController: FindNicePlaceViewModelDelegate {
    func getPlaces(places: [PlaceModel]) {
        let viewController = NicePlacesViewController(nicePlaces: places)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showError() {
        // TO DO
    }
    
    func showLoading() {
        // TO DO
    }
}
