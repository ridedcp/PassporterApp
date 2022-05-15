//
//  CityMapper.swift
//  DigihuntingApp
//
//  Created by Daniel Cano Platero on 13/5/22.
//

import Foundation

extension City {
    func cityMapper() -> CityModel? {
        let city = CityModel(name: name,
                             cover: self.cover,
                             latitude: self.location.latitude,
                             longitude: self.location.longitude,
                             address: self.address)
        return city
    }
}
