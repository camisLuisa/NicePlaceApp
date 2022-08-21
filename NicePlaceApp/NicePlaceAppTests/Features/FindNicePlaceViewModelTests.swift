//
//  FindNicePlaceViewModelTests.swift
//  NicePlaceAppTests
//
//  Created by Camila Luísa Farias on 21/08/22.
//

import XCTest
@testable import NicePlaceApp

class FindNicePlaceViewModelTests: XCTestCase {
    var sut: FindNicePlaceViewModel!
    var mockedService: MockedFoursquareApiManagerProtocol!
    var mockedDelegate: MockedFindNicePlaceViewModelDelegate!
    
    override func setUp() {
        super.setUp()
        mockedService = MockedFoursquareApiManagerProtocol()
        mockedDelegate = MockedFindNicePlaceViewModelDelegate()
        sut = FindNicePlaceViewModel(service: mockedService)
        sut.delegate = mockedDelegate
    }

    override func tearDown() {
        super.tearDown()
        mockedService = nil
        mockedDelegate = nil
        sut = nil
    }
    
    func test_placeSeach_withSuccess_shouldCallDelegateGetPlaces() {
        mockedService.mockedResponse = FoursquareApiResponse(results: [FoursquareResult(name: "Coffe")])
        
        sut.findPlaces(with: "Coffe", latitude: 0.0, longitude: 0.0)
        
        XCTAssertTrue(mockedDelegate.invokedShowloading)
        XCTAssertTrue(mockedDelegate.invokedGetPlaces)
    }
    
    func test_placeSeach_withFailed_shouldCallDelegateShowError() {
        mockedService.mockedError = .errorDecode
        
        sut.findPlaces(with: "Coffe", latitude: 0.0, longitude: 0.0)
        
        XCTAssertTrue(mockedDelegate.invokedShowloading)
        XCTAssertTrue(mockedDelegate.invokedShowError)
    }
}
