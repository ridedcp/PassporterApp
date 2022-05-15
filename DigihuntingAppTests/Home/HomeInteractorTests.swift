//
//  HomeInteractorTests.swift
//  DigihuntingAppTests
//
//  Created by Daniel Cano Platero on 14/5/22.
//

import XCTest
@testable import DigihuntingApp

class HomeInteractorTests: XCTestCase {
    
    var sut: HomeInteractor?
    var repositoryMock: HomeRepositoryMock!
    
    override func setUp() {
        super.setUp()
        repositoryMock = HomeRepositoryMock()
        sut = HomeInteractor(repository: repositoryMock)
    }
    
    func testGetCity_whenRepositoryFailures_returnsError() {
        //Given
        let city = ""
        repositoryMock.success = false
        let error = NetworkingError.genericError
        
        //When
        sut?.getCity(city: city, completion: { result in
            switch result {
            case .failure(let networkingError):
                //Then
                XCTAssertEqual(error, networkingError)
            default:
                //Then
                XCTAssertNil("Repository should failure")
            }
        })
    }
    
    func testGetCity_whenRepositorySuccess_returnsCities() {
        //Given
        let city = "Barcelona"
        repositoryMock.success = true
        
        //When
        sut?.getCity(city: city, completion: { result in
            switch result {
            case .success(let city):
                //Then
                XCTAssertNotNil(city)
            default:
                //Then
                XCTAssertNil("Repository should success")
            }
        })
    }
}
