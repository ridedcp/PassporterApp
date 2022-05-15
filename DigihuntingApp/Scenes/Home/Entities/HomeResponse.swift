//
//  HomeResponse.swift
//  DigihuntingApp
//
//  Created by Daniel Cano Platero on 12/5/22.
//

import Foundation

struct HomeResponse: Codable {
    let results: [City]
}

// MARK: - Result
struct City: Codable {
    let type: TypeEnum
    let name: String
    let location: Location
    let address: String
    let cover: String?
}

// MARK: - Location
struct Location: Codable {
    let latitude, longitude: Double
}

enum TypeEnum: String, Codable {
    case country = "country"
}
