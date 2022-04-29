//
//  HeroCellViewModel.swift
//  All Heroes
//
//  Created by Alik Nigay on 29.04.2022.
//

import Foundation

protocol HeroCellViewModelProtocol {
    var name: String { get }
    var imageData: Data? { get }
    
    init(hero: Hero)
}

class HeroCellViewModel: HeroCellViewModelProtocol {
    var name: String {
        hero.name ?? ""
    }
    
    var imageData: Data? {
        NetworkManager.shared.fetchImage(urlString: hero.images?.sm ?? "")
    }
    
    private var hero: Hero!
    
    required init(hero: Hero) {
        self.hero = hero
    }
    
    
}
