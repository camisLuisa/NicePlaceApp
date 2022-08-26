//
//  TextfieldError.swift
//  NicePlaceApp
//
//  Created by Camila Luísa Farias on 25/08/22.
//

import Foundation

enum TextfieldError: Error {
    case emptyTextfield
    case outOfRadiusValueLimit
    
    var messageError: String {
        switch self {
        case .emptyTextfield:
            return "Category, latitude and longitude cannot be empty."
        case .outOfRadiusValueLimit:
            return "Radius must be between 0 and 100000."
        }
    }
}
