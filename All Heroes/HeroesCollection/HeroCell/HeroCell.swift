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
    
    var heroCellViewModel: HeroCellViewModelProtocol! {
        didSet {
            imageView.layer.cornerRadius = 15
            
            nameLabel.text = heroCellViewModel.name
            DispatchQueue.global(qos: .utility).async {
                if let imageData = self.heroCellViewModel.imageData {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: imageData)
                        self.activityIndicator.stopAnimating()
                    }
                }
            }
        }
    }
}
