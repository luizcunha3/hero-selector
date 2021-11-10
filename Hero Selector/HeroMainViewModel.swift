//
//  HeroMainViewModel.swift
//  Hero Selector
//
//  Created by Luiz Cunha on 09/11/21.
//

import Foundation

final class HeroMainViewModel: ObservableObject {
    
    @Published var selectedHero: Hero?
    @Published var isLoading = false
    private var heroService = HeroService()
    
    func getRandomHero() {
        let randomId = String(Int.random(in: 1...99))
        heroService.getHeroById(id: randomId) { result in
            switch result {
            case .success(let response):
                print(response)
                return
            case .failure(let error):
                print(error)
                return
                
            }
        
        }
    }
    
}
