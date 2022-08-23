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
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let searchTextField: UITextField = {
        let textField = UITextField()
         textField.placeholder = "Find nice places"
        textField.backgroundColor = UIColor(named: "TextFieldBackground")
        textField.layer.cornerRadius = 5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Seach", for: .normal)
        button.backgroundColor = UIColor(named: "BackgroundColor")
        button.layer.cornerRadius = 5
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(searchButtonAction), for: .touchUpInside)
        return button
    }()
    
    let loadingView: LoadingView = {
        let loadingView = LoadingView()
        return loadingView
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
        } else {
            let alert = UIAlertController(title: "Ops!", message: "the search field cannot be empty.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel)
            alert.addAction(action)
            
            present(alert, animated: true)
        }
    }
}

// MARK: Setup View
extension FindNicePlaceViewController {
    private func setupView() {
        title = "NicePlaceApp"
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        setupSeachTextField()
        setupSeachButton()
        setupLoadingView()
    }
    
    private func setupSeachTextField() {
        view.addSubview(contentSearchView)
        
        NSLayoutConstraint.activate([
            contentSearchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentSearchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentSearchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentSearchView.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        contentSearchView.addSubview(searchTextField)
        
        NSLayoutConstraint.activate([
            searchTextField.centerYAnchor.constraint(equalTo: contentSearchView.centerYAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: contentSearchView.leadingAnchor, constant: 8),
            searchTextField.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func setupSeachButton() {
        contentSearchView.addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            searchButton.centerYAnchor.constraint(equalTo: contentSearchView.centerYAnchor),
            searchButton.leadingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: 8),
            searchButton.trailingAnchor.constraint(equalTo: contentSearchView.trailingAnchor, constant: -8),
            searchButton.heightAnchor.constraint(equalToConstant: 32),
            searchButton.widthAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    private func setupLoadingView() {
        view.addSubview(loadingView)
        loadingView.isHidden = true
        
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - FindNicePlaceViewModelDelegate
extension FindNicePlaceViewController: FindNicePlaceViewModelDelegate {
    func getPlaces(places: [PlaceModel]) {
        loadingView.isHidden = true
        let viewController = NicePlacesViewController(nicePlaces: places)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showError() {
        let alert = UIAlertController(title: "Ops!", message: "Something went wrong. Please try again later.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    func showLoading() {
        loadingView.isHidden = false
    }
}
