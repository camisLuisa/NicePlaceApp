//
//  FoursquareApiModel.swift
//  NicePlaceApp
//
//  Created by Camila Luísa Farias on 21/08/22.
//

import Foundation

struct FoursquareApiResponse: Codable, Equatable {
    
    let results: [FoursquareResult]
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

struct FoursquareResult: Codable, Equatable {
    let name: String
    let location: location

    enum CodingKeys: String, CodingKey {
        case name
        case location
    }
}

struct location: Codable, Equatable {
    let formattedAddress: String

    enum CodingKeys: String, CodingKey {
        case formattedAddress = "formatted_address"
    }
}
