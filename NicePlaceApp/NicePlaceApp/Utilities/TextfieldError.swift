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
            return NSLocalizedString("emptyTextfield_message", comment: "")
        case .outOfRadiusValueLimit:
            return NSLocalizedString("outOfRadiusValueLimi_message", comment: "")
        }
    }
}
