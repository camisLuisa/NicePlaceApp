//
//  FindNicePlaceViewModel.swift
//  NicePlaceApp
//
//  Created by Camila Luísa Farias on 21/08/22.
//

import Foundation

protocol FindNicePlaceViewModelDelegate: AnyObject {
    func getPlaces(places: [PlaceModel])
    func showError()
    func showLoading()
}

protocol FindNicePlaceViewModelProtocol {
    var delegate: FindNicePlaceViewModelDelegate? { get set }
    func findPlaces(with name: String, latitude: Float, longitude: Float)
}

class FindNicePlaceViewModel {
    let service: FoursquareApiManagerProtocol
    weak var delegate: FindNicePlaceViewModelDelegate?
    
    init(service: FoursquareApiManagerProtocol = FoursquareApiManager()) {
        self.service = service
    }
    
    func findPlaces(with name: String, latitude: Float, longitude: Float) {
        delegate?.showLoading()
        service.placeSeach(placeName: name, latitude: latitude, longitude: latitude) { response in
            switch response {
            case .success(let places):
                let placesResponse = places.results.map { foursquareResult in
                    PlaceModel(with: foursquareResult)
                }
                
                self.delegate?.getPlaces(places: placesResponse)
            case .failure:
                self.delegate?.showError()
            }
        }
    }
}
