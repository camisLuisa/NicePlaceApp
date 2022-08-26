//
//  FindNicePlaceViewController.swift
//  NicePlaceApp
//
//  Created by Camila Luísa Farias on 21/08/22.
//

import UIKit
import CoreLocation

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
    let locationManager = CLLocationManager()
    var latitude: Float?
    var longitude: Float?
    
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
        setupLocationManager()

        viewModel.delegate = self
    }
    
    private func showAlertError(message: String) {
        let alert = UIAlertController(title: NSLocalizedString("error_title", comment: ""), message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .cancel)
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    private func setupLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        startUserSignificantLocationChanges()
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
        showAlertError(message: NSLocalizedString("error_message", comment: ""))
    }
    
    func showLoading() {
        loadingView.isHidden = false
    }
}

// MARK: - FindNicePlaceContentViewDelegate
extension FindNicePlaceViewController: FindNicePlaceContentViewDelegate {
    func submitContent(submittedContent: SubmittedContent) {
        if let latitude = self.latitude, let longitude = self.longitude {
            locationManager.stopUpdatingLocation()
            viewModel.findPlaces(with: submittedContent.category, latitude: latitude, longitude: longitude, radius: submittedContent.radius)
        }
    }
    
    func incorrectContent(error: TextfieldError) {
        showAlertError(message: error.messageError)
    }
}

// MARK: - CLLocationManagerDelegate
extension FindNicePlaceViewController: CLLocationManagerDelegate {
    func startUserSignificantLocationChanges() {
        if !CLLocationManager.significantLocationChangeMonitoringAvailable() {
            return
        }
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func locationManager(_ manager: CLLocationManager,  didUpdateLocations locations: [CLLocation]) {
        if let latitude = locations.last?.coordinate.latitude, let longitude = locations.last?.coordinate.longitude {
            self.latitude = Float(latitude)
            self.longitude = Float(longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
       if let error = error as? CLError, error.code == .denied {
           showAlertError(message: "Location updates are not authorized. Please go on device's configuration and authorized it.")
          manager.stopMonitoringSignificantLocationChanges()
          return
       }
    }
}
