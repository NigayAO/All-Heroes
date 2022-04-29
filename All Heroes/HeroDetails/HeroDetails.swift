//
//  DetailViewController.swift
//  All Heroes
//
//  Created by Alik Nigay on 27.04.2022.
//

import UIKit

class HeroDetails: UIViewController {
    
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
    @IBOutlet weak var alignment: UILabel!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var hero: Hero!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setup()
    }
    
    private func setUI() {
        imageView.layer.cornerRadius = 15
        backgroundImage.layer.opacity = 0.3
        
        if let imageData = NetworkManager.shared.fetchImage(urlString: hero.images?.lg ?? "") {
            DispatchQueue.main.async {
                self.backgroundImage.image = UIImage(data: imageData)
            }
        }
    }
    
    private func setup() {
        title = hero.name
        
        intelligenceLabel.text = "Intelligence: \(hero.powerstats?.intelligence ?? 0) 🧠"
        strengthLabel.text = "Strength: \(hero.powerstats?.strength ?? 0) 💪"
        speedLabel.text = "Speed: \(hero.powerstats?.speed ?? 0) 👟"
        durabilityLabel.text = "Durability: \(hero.powerstats?.durability ?? 0) 🛡"
        powerLabel.text = "Power: \(hero.powerstats?.power ?? 0) ⚔️"
        combatLabel.text = "Combar: \(hero.powerstats?.combat ?? 0) 🥊"
        
        heightLabel.text = "Height: \(hero.appearance?.height?[0] ?? "0")"
        weightLabel.text = "Weight: \(hero.appearance?.weight?[0] ?? "0")"
        fullnameLabel.text = "Fullname: \(hero.biography?.fullName ?? "...")"
        publisherLabel.text = "Publisher: \(hero.biography?.publisher ?? "...")"
        firstAppearance.text = "First appearence: \(hero.biography?.firstAppearance ?? "No")"
        alignment.text = "Alignment: \(hero.biography?.alignment ?? "")"
        
        if let imageData = NetworkManager.shared.fetchImage(urlString: hero.images?.sm ?? "") {
            imageView.image = UIImage(data: imageData)
        }
    }
}
