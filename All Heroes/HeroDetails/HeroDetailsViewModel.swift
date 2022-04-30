//
//  HeroDetailsViewModel.swift
//  All Heroes
//
//  Created by Alik Nigay on 29.04.2022.
//

import Foundation

protocol HeroDetailsViewModelProtocol {
    init(hero: Hero)
    
    var name: String { get }
    
    var imageView: Data? { get }
    var backgroundImage: Data? { get }
    
    var intelligence: String { get }
    var strength: String { get }
    var speed: String { get }
    var durability: String { get }
    var power: String { get }
    var combat: String { get }
    
    var height: String { get }
    var weight: String { get }
    var fullname: String { get }
    var publisher: String { get }
    var firstAppearance: String { get }
    var alignment: String { get }
}

class HeroDetailsViewModel: HeroDetailsViewModelProtocol {
    var name: String {
        hero.name ?? "Some problem"
    }
    
    var imageView: Data? {
        NetworkManager.shared.fetchImage(urlString: hero.images?.sm ?? "Some problem")
    }
    
    var backgroundImage: Data? {
        NetworkManager.shared.fetchImage(urlString: hero.images?.lg ?? "Some problem")
    }
    
    var intelligence: String {
        "Intelligence: \(hero.powerstats?.intelligence ?? 0) 🧠"
    }
    
    var strength: String {
        "Strength: \(hero.powerstats?.strength ?? 0) 💪"
    }
    
    var speed: String {
        "Speed: \(hero.powerstats?.speed ?? 0) 👟"
    }
    
    var durability: String {
        "Durability: \(hero.powerstats?.durability ?? 0) 🛡"
    }
    
    var power: String {
        "Power: \(hero.powerstats?.power ?? 0) ⚔️"
    }
    
    var combat: String {
        "Combar: \(hero.powerstats?.combat ?? 0) 🥊"
    }
    
    var height: String {
        "Height: \(hero.appearance?.height?[0] ?? "0")"
    }
    
    var weight: String {
        "Weight: \(hero.appearance?.weight?[0] ?? "0")"
    }
    
    var fullname: String {
        "Fullname: \(hero.biography?.fullName ?? "Some problem")"
    }
    
    var publisher: String {
        "Publisher: \(hero.biography?.publisher ?? "Some problem")"
    }
    
    var firstAppearance: String {
        "First appearence: \(hero.biography?.firstAppearance ?? "Some problem")"
    }
    
    var alignment: String {
        "Alignment: \(hero.biography?.alignment ?? "Some problem")"
    }
    
    private let hero: Hero!
    
    required init(hero: Hero) {
        self.hero = hero
    }
    
    
}
