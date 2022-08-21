//
//  PlaceModel.swift
//  NicePlaceApp
//
//  Created by Camila Luísa Farias on 21/08/22.
//

import Foundation

struct PlaceModel {
    let name: String
    
    init(with response: FoursquareResult) {
        self.name = response.name
    }
    
    init(name: String) {
        self.name = name
    }
}
