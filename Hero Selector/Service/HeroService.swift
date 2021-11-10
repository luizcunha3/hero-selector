//
//  HeroService.swift
//  Hero Selector
//
//  Created by Luiz Cunha on 09/11/21.
//

import Foundation

enum HeroServiceError: Error {
    case apiCallError(Error)
    case malformedURL
    case dataError
    case unnexpectedDataFormat
    
}

class HeroService {
    
    let apiEndpoint = "https://superheroapi.com/api/1301826150248235/"
    
    let networkingProvider: Networking
    
    init(networkingProvider: Networking = MainNetworking()) {
        self.networkingProvider = networkingProvider
    }
    
    func getHeroById(id: String, _ completion: @escaping (Result<Hero, HeroServiceError>) -> Void) {
        let apiCall = apiEndpoint + id
        guard let url = URL(string: apiCall) else {
            completion(.failure(.malformedURL))
            return
        }
        
        let task = networkingProvider.loadTaskFor(url: url) { data, response, error in
            if let safeError = error {
                completion(.failure(.apiCallError(safeError)))
                return
            }
            
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            
            guard let hero = try? JSONDecoder().decode(Hero.self, from: safeData) else {
                completion(.failure(.unnexpectedDataFormat))
                return
            }
            
            completion(.success(hero))
        }
        task.resume()
    }
    
    func searchHeroBy(name heroName: String, _ completion: @escaping (Result<SearchResponse, HeroServiceError>) -> Void) {
        let apiCall = "search/\(heroName)"
        guard let url = URL(string: apiCall) else {
            completion(.failure(.malformedURL))
            return
        }
        
        let task = networkingProvider.loadTaskFor(url: url) { data, response, error in
            if let safeError = error {
                completion(.failure(.apiCallError(safeError)))
                return
            }
            
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            
            guard let searchResponse = try? JSONDecoder().decode(SearchResponse.self, from: safeData) else {
                completion(.failure(.unnexpectedDataFormat))
                return
            }
            
            completion(.success(searchResponse))
        }
        task.resume()
    }
}
