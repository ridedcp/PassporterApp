//
//  HomeRepositoryMock.swift
//  DigihuntingAppTests
//
//  Created by Daniel Cano Platero on 14/5/22.
//

import Foundation
@testable import DigihuntingApp

final class HomeRepositoryMock: CommonRepositoryInterface {
    
    var success: Bool = false
    var cityArray = [CityModel]()
    
    func fetchCity(city: String, completion: @escaping (Result<Set<CityModel>?, NetworkingError>) -> Void) {
            
        cityArray.append(CityFactory.createCity())
        
        if success {
            completion(.success(Set(cityArray)))
        } else {
            completion(.failure(.genericError))
        }
    }
}
