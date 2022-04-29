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
    func numberOfItems() -> Int
    func heroCellViewModel(indexPath: IndexPath) -> HeroCellViewModelProtocol
}

class HeroCollectionViewModel: HeroCollectionViewModelProtocol {
    var heroes = [Hero]()
    var filteredHeroes = [Hero]()
    
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
    
    func numberOfItems() -> Int {
        heroes.count
    }
    
    func heroCellViewModel(indexPath: IndexPath) -> HeroCellViewModelProtocol {
        HeroCellViewModel(hero: heroes[indexPath.item])
    }
    
    func numberOfItems(isFiltering: Bool) -> Int {
        isFiltering ? filteredHeroes.count : heroes.count
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
}
