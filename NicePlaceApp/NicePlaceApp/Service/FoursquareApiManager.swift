//
//  FoursquareService.swift
//  NicePlaceApp
//
//  Created by Camila Luísa Farias on 21/08/22.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol { func resume() }

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
extension URLSession: URLSessionProtocol {
    func dataTask(urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return dataTask(with: urlRequest, completionHandler: completionHandler) as URLSessionDataTaskProtocol
    }
}

protocol FoursquareApiManagerProtocol {
    func placeSeach(placeName: String, latitude: Float, longitude: Float, completion: @escaping (Result<FoursquareApiResponse, NetworkError>) -> Void)
}

class FoursquareApiManager: FoursquareApiManagerProtocol {
    private let session: URLSessionProtocol
    private let dispatchQueueWrapper: DispatchQueueWrapperProtocol

    init(
        session: URLSessionProtocol = URLSession.shared,
         dispatchQueueWrapper: DispatchQueueWrapperProtocol = DispatchQueueWrapper()
    ) {
        self.session = session
        self.dispatchQueueWrapper = dispatchQueueWrapper
    }

    func placeSeach(placeName: String, latitude: Float, longitude: Float, completion: @escaping (Result<FoursquareApiResponse, NetworkError>) -> Void) {

        var components = makeFoursquareApiComoponents()
        components.queryItems = [
            URLQueryItem(name: "query", value: "\(placeName)"),
            URLQueryItem(name: "ll", value: "\(latitude) & \(longitude)")
        ]

        guard let url = components.url else {
            completion(.failure(.invalidUrl))
            return
        }

        var urlRequest = URLRequest(url: url, timeoutInterval: 10)
        
        for (key, value) in FoursquareApi.headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }

        let task = session.dataTask(urlRequest: urlRequest) { [weak self] data, urlResponse, error in

            self?.dispatchQueueWrapper.mainAsync {

                if error != nil {
                    completion(.failure(.failed(error: error!)))
                } else if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(FoursquareApiResponse.self, from: data)

                        completion(.success(response))
                    } catch {
                        completion(.failure(.errorDecode))
                    }
                } else {
                    print("unknown dataTask error")
                    completion(.failure(.unknownError))
                }
            }
        }

        task.resume()
    }
}

private extension FoursquareApiManager {
    struct FoursquareApi {
        static let scheme = "https"
        static let host = "api.foursquare.com"
        static let path = "/v3"
        
        static let headers = [
            "Accept": "application/json",
            "Authorization": ""
        ]
    }

    func makeFoursquareApiComoponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = FoursquareApi.scheme
        components.host = FoursquareApi.host
        components.path = FoursquareApi.path + "/places/search"

        return components
    }
}
