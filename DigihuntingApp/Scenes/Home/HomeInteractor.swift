//
//  HomeInteractor.swift
//  DigihuntingApp
//
//  Created by Daniel Cano Platero on 12/5/22.
//

import Foundation

final class HomeInteractor: HomeInteractorInterface {
    
    let repository: CommonRepositoryInterface
    
    init(repository: CommonRepositoryInterface) {
        self.repository = repository
    }
    
    func getCity(city: String, completion: @escaping (Result<Set<CityModel>?, NetworkingError>) -> Void) {
        repository.fetchCity(city: city) { result in
            switch result {
            case .success(let data):
                if let cities = data, !cities.isEmpty {
                    completion(.success(data))
                } else {
                    completion(.failure(.emptyData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
