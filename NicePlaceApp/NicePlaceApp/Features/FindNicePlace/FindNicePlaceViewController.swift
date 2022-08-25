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
    
    let latitudeTextField: UITextField = {
        let textField = UITextField()
         textField.placeholder = "Latitude"
        textField.backgroundColor = UIColor(named: "TextFieldBackground")
        textField.layer.cornerRadius = 5
        textField.keyboardType = .asciiCapableNumberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let longitudeTextField: UITextField = {
        let textField = UITextField()
         textField.placeholder = "Longitude"
        textField.backgroundColor = UIColor(named: "TextFieldBackground")
        textField.layer.cornerRadius = 5
        textField.keyboardType = .asciiCapableNumberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let radiusTextField: UITextField = {
        let textField = UITextField()
         textField.placeholder = "Radius"
        textField.backgroundColor = UIColor(named: "TextFieldBackground")
        textField.layer.cornerRadius = 5
        textField.keyboardType = .asciiCapableNumberPad
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
    
    let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 16
        stackView.backgroundColor = .systemGray6

        return stackView
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
        
        setupContentView()
        setupLoadingView()
    }
    
    private func setupContentView() {
        view.addSubview(contentSearchView)
        contentSearchView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(searchTextField)
        contentStackView.addArrangedSubview(latitudeTextField)
        contentStackView.addArrangedSubview(longitudeTextField)
        contentStackView.addArrangedSubview(radiusTextField)
        contentStackView.addArrangedSubview(searchButton)
        
        NSLayoutConstraint.activate([
            contentSearchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentSearchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentSearchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
                
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentSearchView.topAnchor, constant: 8),
            contentStackView.leadingAnchor.constraint(equalTo: contentSearchView.leadingAnchor, constant: 8),
            contentStackView.trailingAnchor.constraint(equalTo: contentSearchView.trailingAnchor, constant: -8),
            contentStackView.bottomAnchor.constraint(equalTo: contentSearchView.bottomAnchor, constant: -8)
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
        loadingView.isHidden = true

        let alert = UIAlertController(title: "Ops!", message: "Something went wrong. Please try again later.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    func showLoading() {
        loadingView.isHidden = false
    }
}
