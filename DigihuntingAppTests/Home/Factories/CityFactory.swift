//
//  CityFactory.swift
//  DigihuntingAppTests
//
//  Created by Daniel Cano Platero on 14/5/22.
//

import Foundation
@testable import DigihuntingApp

final class CityFactory {
    
    static func createCity() -> CityModel {
        let city = CityModel(name: "Barcelona", cover: "", latitude: 0.0, longitude: 0.0, address: "Balmes, 123")
        return city
    }
}
