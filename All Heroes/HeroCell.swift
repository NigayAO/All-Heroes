//
//  HeroCell.swift
//  All Heroes
//
//  Created by Alik Nigay on 27.04.2022.
//

import UIKit

class HeroCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func initialSetup(hero: Hero) {
        nameLabel.text = hero.name
        if let imageData = NetworkManager.shared.fetchImage(urlString: hero.images?.sm ?? "") {
            imageView.image = UIImage(data: imageData)
            activityIndicator.stopAnimating()
        }
    }
}
