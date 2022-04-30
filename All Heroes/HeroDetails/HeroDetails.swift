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
    
    var viewModel: HeroDetailsViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setup()
    }
    
    private func setUI() {
        imageView.layer.cornerRadius = 15
        backgroundImage.layer.opacity = 0.3
        
        if let imageData = viewModel.backgroundImage {
            DispatchQueue.main.async {
                self.backgroundImage.image = UIImage(data: imageData)
            }
        }
    }
    
    private func setup() {
        title = viewModel.name
        
        intelligenceLabel.text = viewModel.intelligence
        strengthLabel.text = viewModel.strength
        speedLabel.text = viewModel.speed
        durabilityLabel.text = viewModel.durability
        powerLabel.text = viewModel.power
        combatLabel.text = viewModel.combat
        
        heightLabel.text = viewModel.height
        weightLabel.text = viewModel.weight
        fullnameLabel.text = viewModel.fullname
        publisherLabel.text = viewModel.publisher
        firstAppearance.text = viewModel.firstAppearance
        alignment.text = viewModel.alignment
        
        if let imageData = viewModel.imageView {
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: imageData)
            }
        }
    }
}
