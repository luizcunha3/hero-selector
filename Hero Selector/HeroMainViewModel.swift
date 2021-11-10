//
//  HeroMainViewModel.swift
//  Hero Selector
//
//  Created by Luiz Cunha on 09/11/21.
//

import Foundation

protocol MainHeroViewModelInterface {
    func getHeroName() -> String
    func getRandomHero()
    func getHeroById(_ heroId: String)
    func getHeroImageUrl() -> URL?
}

class BaseHeroMainViewModel: MainHeroViewModelInterface, ObservableObject {
    func getHeroName() -> String {
        fatalError("Must Override")
    }
    
    func getRandomHero() {
        fatalError("Must Override")
    }
    
    func getHeroById(_ heroId: String) {
        fatalError("Must Override")
    }
    func getHeroImageUrl() -> URL? {
        fatalError("Must Override")
    }
}

final class MockHeroMainViewModel: BaseHeroMainViewModel {
    override func getHeroName() -> String {
        return "Iron Man"
    }
    
    override func getRandomHero() {
        return
    }
    
    override func getHeroById(_ heroId: String) {
        return
    }
    
    override func getHeroImageUrl() -> URL? {
        return URL(string: "https://www.superherodb.com//pictures2//portraits//10//100//85.jpg")
    }
}

final class HeroMainViewModel: BaseHeroMainViewModel {
    
    @Published var selectedHero: Hero?
    @Published var isLoading = false
    private var heroService = HeroService()
    
    override func getHeroName() -> String {
        return selectedHero?.name ?? "NO NAME"
    }
    
    override func getHeroById(_ heroId: String) {
        heroService.getHeroById(id: heroId) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.selectedHero = response
                }
                return
            case .failure(let error):
                print(error)
                return
                
            }
        
        }
    }
    
    override func getHeroImageUrl() -> URL? {
        return URL(string: self.selectedHero?.image.url ?? "")
    }
    
    override func getRandomHero() {
        let randomId = String(Int.random(in: 1...99))
        self.getHeroById(randomId)
    }
    
}
