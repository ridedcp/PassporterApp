//
//  HomePresenterTests.swift
//  DigihuntingAppTests
//
//  Created by Daniel Cano Platero on 14/5/22.
//

import XCTest
@testable import DigihuntingApp

class HomePresenterTests: XCTestCase {

    var sut: HomePresenter!
    var interactorMock: HomeInteractorMock!
    var routerMock: HomeRouterMock!
    var homeViewSpy: HomeViewSpy!

    override func setUp() {
        super.setUp()
        interactorMock = HomeInteractorMock()
        routerMock = HomeRouterMock()
        sut = HomePresenter(interactor: interactorMock, router: routerMock)
        homeViewSpy = HomeViewSpy()
        sut.view = homeViewSpy
    }
    
    func testGetCity_whenInteractorSuccess_asignCitiesToViewAndCallReloadTable() {
        //Given
        let city = ""
        interactorMock.success = true
        
        //When
        sut.getCity(city: city)
        
        //Then
        XCTAssertNotNil(homeViewSpy.cities)
        XCTAssertTrue(homeViewSpy.reloadTableViewContentCalled)
        XCTAssertTrue(homeViewSpy.showLoadingCalled)
        XCTAssertTrue(homeViewSpy.dismissLoadingCalled)
        XCTAssertTrue(homeViewSpy.showTableViewCalled)
    }
}
