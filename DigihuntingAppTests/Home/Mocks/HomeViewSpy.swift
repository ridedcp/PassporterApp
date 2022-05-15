//
//  HomeViewSpy.swift
//  DigihuntingAppTests
//
//  Created by Daniel Cano Platero on 14/5/22.
//

import Foundation
@testable import DigihuntingApp

final class HomeViewSpy: HomeViewControllerInterface {

    var cities: [CityModel] = []
    var reloadTableViewContentCalled = false
    var showLoadingCalled = false
    var dismissLoadingCalled = false
    var showNoResultsLabelCalled = false
    var showTableViewCalled = false
    var showServerErrorCalled = false
    
    func reloadTableViewContent() {
        reloadTableViewContentCalled = true
    }

    func showLoading() {
        showLoadingCalled = true
    }
    
    func dismissLoading() {
        dismissLoadingCalled = true
    }
    
    func showNoResultsLabel() {
        showNoResultsLabelCalled = true
    }
    
    func showTableView() {
        showTableViewCalled = true
    }
    
    func showServerError() {
        showServerErrorCalled = true
    }
}

