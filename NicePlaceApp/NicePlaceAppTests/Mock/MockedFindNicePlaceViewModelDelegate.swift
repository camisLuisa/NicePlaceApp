//
//  MockedFindNicePlaceViewModelDelegate.swift
//  NicePlaceAppTests
//
//  Created by Camila Luísa Farias on 21/08/22.
//

import XCTest
@testable import NicePlaceApp

class MockedFindNicePlaceViewModelDelegate: FindNicePlaceViewModelDelegate {
    var invokedGetPlaces = false
    var invokedShowError = false
    var invokedShowloading = false
    
    func getPlaces(places: [PlaceModel]) {
        invokedGetPlaces = true
    }
    
    func showError() {
        invokedShowError = true
    }
    
    func showLoading() {
        invokedShowloading = true
    }
    
    
}
