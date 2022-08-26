//
//  MockedFoursquareApiManagerProtocol.swift
//  NicePlaceAppTests
//
//  Created by Camila Luísa Farias on 21/08/22.
//

import XCTest
@testable import NicePlaceApp

class MockedFoursquareApiManagerProtocol: FoursquareApiManagerProtocol {
    var mockedResponse = FoursquareApiResponse(results: [])
    var mockedError: NetworkError?
    
    func placeSeach(placeName: String, latitude: Float, longitude: Float, radius: Int?, completion: @escaping (Result<FoursquareApiResponse, NetworkError>) -> Void) {
        
        if let mockedError = mockedError {
            completion(.failure(mockedError))
            
            return
        }
        
        completion(.success(mockedResponse))
    }
    
    
}
