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
            nameLabel.text = heroCellViewModel.name
            if let imageData = heroCellViewModel.imageData {
                imageView.image = UIImage(data: imageData)
                activityIndicator.stopAnimating()
            }
        }
    }
}
