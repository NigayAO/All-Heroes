//
//  HeroModel.swift
//  About Hero
//
//  Created by Alik Nigay on 06.12.2021.
//

import Foundation

enum Link: String {
    case allHeroes = "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/all.json"
}

struct Hero: Codable {
    let id: Int?
    let name: String?
    let slug: String?
    let powerstats: PowerStats?
    let appearance: Appearance?
    let biography: Biography?
    let work: Work?
    let connections: Connections?
    let images: Images?
    
    init(value: [String: Any]) {
        id = value["id"] as? Int
        name = value["name"] as? String
        slug = value["slug"] as? String
        
        let powerstatsDict = value["powerstats"] as? [String: Int] ?? [:]
        powerstats = PowerStats(value: powerstatsDict)
        
        let appearanceDict = value["appearance"] as? [String: Any] ?? [:]
        appearance = Appearance(value: appearanceDict)
        
        let biographyDict = value["biography"] as? [String: Any] ?? [:]
        biography = Biography(value: biographyDict)
        
        let workDict = value["work"] as? [String: String] ?? [:]
        work = Work(value: workDict)
        
        let connectionsDict = value["connections"] as? [String: String] ?? [:]
        connections = Connections(value: connectionsDict)
        
        let imagesDict = value["images"] as? [String: String] ?? [:]
        images = Images(value: imagesDict)
    }
    
    static func getAllHeroes(value: Any) -> [Hero] {
        guard let allHeroes = value as? [[String: Any]] else { return [] }
        return allHeroes.compactMap{ Hero(value: $0)}
    }
}

struct PowerStats: Codable {
    let intelligence: Int?
    let strength: Int?
    let speed: Int?
    let durability: Int?
    let power: Int?
    let combat: Int?
    
    init(value: [String: Int]) {
        intelligence = value["intelligence"]
        strength = value["strength"]
        speed = value["speed"]
        durability = value["durability"]
        power = value["power"]
        combat = value["value"]
    }
}

struct Appearance: Codable {
    let gender: String?
    let race: String?
    let height: [String]?
    let weight: [String]?
    let eyeColor: String?
    let hairColor: String?
    
    init(value: [String: Any]) {
        gender = value["gender"] as? String
        race = value["race"] as? String
        height = value["height"] as? [String]
        weight = value["weight"] as? [String]
        eyeColor = value["eyeColor"] as? String
        hairColor = value["hairColor"] as? String
    }
}

struct Biography: Codable {
    let fullName: String?
    let alterEgos: String?
    let aliases: [String]?
    let placeOfBirth: String?
    let firstAppearance: String?
    let publisher: String?
    let alignment: String?
    
    init(value: [String: Any]) {
        fullName = value["fullName"] as? String
        alterEgos = value["alterEgos"] as? String
        aliases = value["aliases"] as? [String]
        placeOfBirth = value["placeOfBirth"] as? String
        firstAppearance = value["firstAppearance"] as? String
        publisher = value["publisher"] as? String
        alignment = value["alignment"] as? String
    }
}

struct Work: Codable {
    let occupation: String?
    let base: String?
    
    init(value: [String: String]) {
        occupation = value["occupation"]
        base = value["base"]
    }
}

struct Connections: Codable {
    let groupAffiliation: String?
    let relatives: String?
    
    init(value: [String: String]) {
        groupAffiliation = value["groupAffiliation"]
        relatives = value["relatives"]
    }
}

struct Images: Codable {
    let xs: String?
    let sm: String?
    let md: String?
    let lg: String?
    
    init(value: [String: String]) {
        xs = value["xs"]
        sm = value["sm"]
        md = value["md"]
        lg = value["lg"]
    }
}
