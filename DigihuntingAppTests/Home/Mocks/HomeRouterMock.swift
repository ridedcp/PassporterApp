//
//  HomeRouterMock.swift
//  DigihuntingAppTests
//
//  Created by Daniel Cano Platero on 14/5/22.
//

import Foundation
@testable import DigihuntingApp

final class HomeRouterMock: HomeRouterInterface {
    func navigateToDetailViewController(for view: HomeViewControllerInterface, data: CityModel) {}
}
