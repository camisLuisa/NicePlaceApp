//
//  NetworkError.swift
//  NicePlaceApp
//
//  Created by Camila Luísa Farias on 21/08/22.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case errorDecode
    case failed(error: Error)
    case unknownError
}
