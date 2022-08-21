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

    enum CodingKeys: String, CodingKey {
        case name
    }
}
