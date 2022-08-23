//
//  PlaceModel.swift
//  NicePlaceApp
//
//  Created by Camila Luísa Farias on 21/08/22.
//

import Foundation

struct PlaceModel {
    let name: String
    let address: String
    
    init(with response: FoursquareResult) {
        self.name = response.name
        self.address = response.location.formattedAddress
    }
    
    init(name: String, address: String) {
        self.name = name
        self.address = address
    }
}
