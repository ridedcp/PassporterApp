//
//  Networking.swift
//  DigihuntingApp
//
//  Created by Daniel Cano Platero on 12/5/22.
//

import Foundation

protocol NetworkingInterface {
    func createSimpleGetRequest(url: String, city: String) -> URLRequest?
    func decodeSimpleObject<T: Codable>(data: Data) -> T?
}

final class Networking: NetworkingInterface {
    
    enum Url {
        static let baseUrl = "http://myjson.dit.upm.es/api/bins/e8zj"
    }
    
    private func createValidUrl(url: String, city: String) -> URL? {
        guard let urlComponents = URLComponents(string: url) else {
            return nil
        }
                
        guard let urlString = urlComponents.url else {
            return nil
        }
        return urlString
    }
    
    func createSimpleGetRequest(url: String, city: String) -> URLRequest? {
        guard let completeUrl = createValidUrl(url: url, city: city) else {
            return nil
        }
        
        return URLRequest(url: completeUrl)
    }
    
    func decodeSimpleObject<T: Codable>(data: Data) -> T? {
        guard let apiModel = try? JSONDecoder().decode(T.self, from: data) else {
            return nil
        }
        return apiModel
    }
}
