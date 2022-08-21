//
//  UrlSessionMock.swift
//  NicePlaceAppTests
//
//  Created by Camila Luísa Farias on 21/08/22.
//

import XCTest
@testable import NicePlaceApp

class UrlSessionMock: URLSessionProtocol {
    var mockResponse: Data?
    var error: NetworkError?

    func dataTask(
        urlRequest: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        if let mockResponse = mockResponse {
            completionHandler(
                mockResponse, HTTPURLResponse(
                    url: URL(string: "google.com")!,
                    statusCode: 200,
                    httpVersion: nil,
                    headerFields: nil),
                nil)
        } else if let error = error {
            completionHandler(nil, nil, error)
        }
        return URLSessionDataTaskProtocolMock()
    }
}
