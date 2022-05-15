//
//  CommonRepository.swift
//  DigihuntingApp
//
//  Created by Daniel Cano Platero on 12/5/22.
//

import Foundation

enum NetworkingError: Error {
    case genericError
    case errorParsing
    case emptyData
}

protocol CommonRepositoryInterface {
    func fetchCity(city: String,
                        completion: @escaping (Result<Set<CityModel>?, NetworkingError>) -> Void)
}

final class CommonRepository: CommonRepositoryInterface {
    
    let networking: NetworkingInterface
    let session: URLSession
    
    init(networking: NetworkingInterface,
         session: URLSession) {
        self.networking = networking
        self.session = session
    }
    
    func fetchCity(city: String,
                   completion: @escaping (Result<Set<CityModel>?, NetworkingError>) -> Void) {
        
        guard let request = networking.createSimpleGetRequest(url: Networking.Url.baseUrl, city: city) else {
            return
        }
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            guard let data = data,
            let apiModel: HomeResponse = self.networking.decodeSimpleObject(data: data) else {
                return completion(.failure(.genericError))
            }
            
            let finalResults = apiModel.results.compactMap { $0.cityMapper() }
            return completion(.success(Set(finalResults)))
        })
        task.resume()
    }
}
