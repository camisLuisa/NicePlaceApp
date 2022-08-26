//
//  FindNicePlaceViewController.swift
//  NicePlaceApp
//
//  Created by Camila Luísa Farias on 21/08/22.
//

import UIKit

class FindNicePlaceViewController: UIViewController {
    
    lazy var findNicePlaceContentView: FindNicePlaceContentView = {
        let contentView = FindNicePlaceContentView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.delegate = self
        return contentView
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

// MARK: Setup View
extension FindNicePlaceViewController {
    private func setupView() {
        title = "NicePlaceApp"
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        setupContentView()
        setupLoadingView()
    }
    
    private func setupContentView() {
        view.addSubview(findNicePlaceContentView)
        
        NSLayoutConstraint.activate([
            findNicePlaceContentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            findNicePlaceContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            findNicePlaceContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
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

// MARK: - FindNicePlaceContentViewDelegate
extension FindNicePlaceViewController: FindNicePlaceContentViewDelegate {
    func submitContent(submittedContent: SubmittedContent) {
        viewModel.findPlaces(with: submittedContent.category, latitude: submittedContent.latitude, longitude: submittedContent.longitude, radius: submittedContent.radius)
    }
    
    func incorrectContent(error: TextfieldError) {
        let alert = UIAlertController(title: "Ops!", message: error.messageError, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(action)
        
        present(alert, animated: true)
    }
}
