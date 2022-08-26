//
//  FoursquareServiceTests.swift
//  NicePlaceAppTests
//
//  Created by Camila Luísa Farias on 21/08/22.
//

import XCTest
@testable import NicePlaceApp

class FoursquareApiManagerTests: XCTestCase {
    var dispatchQueueMock: DispatchQueueWrapperProtocolMock!
    var urlSessionMock: UrlSessionMock!
    var sut: FoursquareApiManager!
    
    override func setUp() {
        super.setUp()
        dispatchQueueMock = DispatchQueueWrapperProtocolMock()
        urlSessionMock = UrlSessionMock()
        sut = FoursquareApiManager(session: urlSessionMock, dispatchQueueWrapper: dispatchQueueMock)
    }
    
    override func tearDown() {
        super.tearDown()
        dispatchQueueMock = nil
        urlSessionMock = nil
        sut = nil
    }
    
    func test_placeSeach_withSuccess_shouldReturnFoursquareApiResponse() {
        //given
        let foursquareApiResponse = FoursquareApiResponse(results: [])
        urlSessionMock.mockResponse = getMockFoursquareApiResponse(with: foursquareApiResponse)
        var checkFoursquareApiResponse: FoursquareApiResponse?
        
        //When
        sut.placeSeach(placeName: "", latitude: 0, longitude: 0, radius: nil) { result in
            switch result {
            case .success(let reponse):
                checkFoursquareApiResponse = reponse
            case .failure:
                XCTFail()
            }
        }
        
        //Then
        XCTAssertNotNil(checkFoursquareApiResponse)
        XCTAssertEqual(foursquareApiResponse, checkFoursquareApiResponse)
    }
    
    func test_placeSeach_withFailed_shouldErrorNotNil() {
        urlSessionMock.mockResponse = Data()
        var errorResponse: NetworkError?
        
        sut.placeSeach(placeName: "", latitude: 0, longitude: 0, radius: nil) { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                errorResponse = error
            }
        }
        
        XCTAssertNotNil(errorResponse)
    }
    
    private func getMockFoursquareApiResponse(with response: FoursquareApiResponse) -> Data? {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let data = try? encoder.encode(response)

        return data
    }
}
