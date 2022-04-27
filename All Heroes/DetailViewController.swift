//
//  DetailViewController.swift
//  All Heroes
//
//  Created by Alik Nigay on 27.04.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var intelligenceLabel: UILabel!
    @IBOutlet weak var strengthLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var durabilityLabel: UILabel!
    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var combatLabel: UILabel!
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var firstAppearance: UILabel!
    
    
//    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var hero: Hero!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        title = hero.name
        
        intelligenceLabel.text = "Intelligence: \(hero.powerstats?.intelligence ?? 0)"
        strengthLabel.text = "Strenght: \(hero.powerstats?.strength ?? 0)"
        speedLabel.text = "Speed: \(hero.powerstats?.speed ?? 0)"
        durabilityLabel.text = "Durability: \(hero.powerstats?.durability ?? 0)"
        powerLabel.text = "Power: \(hero.powerstats?.power ?? 0)"
        combatLabel.text = "Combat: \(hero.powerstats?.combat ?? 0)"
        
        heightLabel.text = "Height: \(hero.appearance?.height?[0] ?? "Nope")"
        weightLabel.text = "Weight: \(hero.appearance?.weight?[0] ?? "Nope")"
        
        fullnameLabel.text = "Fullname: \(hero.biography?.fullName ?? "...")"
        publisherLabel.text = "Publisher: \(hero.biography?.publisher ?? "...")"
        firstAppearance.text = "First appearance: \(hero.biography?.firstAppearance ?? "No")"
        
        if let imageData = NetworkManager.shared.fetchImage(urlString: hero.images?.lg ?? "") {
            imageView.image = UIImage(data: imageData)
        }
    }
}
