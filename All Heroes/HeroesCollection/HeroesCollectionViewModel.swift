//
//  HeroesCollectionViewModel.swift
//  All Heroes
//
//  Created by Alik Nigay on 29.04.2022.
//

import Foundation

protocol HeroCollectionViewModelProtocol {
    var heroes: [Hero] { get }
    
    func fetchHeroes(completion: @escaping() -> Void)
    func heroCellViewModel(isFiltering: Bool, indexPath: IndexPath) -> HeroCellViewModelProtocol
    func filterContentForSearchText(for searchText: String, scope: String, completion: @escaping() -> Void)
    func getHero(isFiltering: Bool) -> [Hero]
    func heroDetailsViewModel(at indexPath: IndexPath, isFiltering: Bool) -> HeroDetailsViewModelProtocol
}

class HeroCollectionViewModel: HeroCollectionViewModelProtocol {
    var heroes = [Hero]()
    private var filteredHeroes = [Hero]()
        
    func fetchHeroes(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchData { result in
            switch result {
            case .success(let receivedHeroes):
                self.heroes = receivedHeroes
                DispatchQueue.main.async {
                    completion()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func heroCellViewModel(isFiltering: Bool, indexPath: IndexPath) -> HeroCellViewModelProtocol {
        HeroCellViewModel(hero: getHero(isFiltering: isFiltering)[indexPath.item])
    }
    
    func filterContentForSearchText(for searchText: String, scope: String = "All Heroes", completion: @escaping() -> Void) {
        filteredHeroes = heroes.filter({ hero in
            guard let name = hero.name else { return false }
            guard let publisher = hero.biography?.publisher else { return false }
            guard let alignment = hero.biography?.alignment else { return false }
            
            switch scope {
            case "Alignment":
                return alignment.lowercased().contains(searchText.lowercased())
            case "Publisher":
                return publisher.lowercased().contains(searchText.lowercased())
            default:
                return name.lowercased().contains(searchText.lowercased())
            }
        })
        DispatchQueue.main.async {
            completion()
        }
    }
    
    func getHero(isFiltering: Bool) -> [Hero] {
        isFiltering ? filteredHeroes : heroes
    }
    
    func heroDetailsViewModel(at indexPath: IndexPath, isFiltering: Bool) -> HeroDetailsViewModelProtocol {
        HeroDetailsViewModel(hero: getHero(isFiltering: isFiltering)[indexPath.item])
    }
}
