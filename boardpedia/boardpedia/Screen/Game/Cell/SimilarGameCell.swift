//
//  SimilarGameCell.swift
//  boardpedia
//
//  Created by 김민희 on 2021/06/03.
//

import UIKit

class SimilarGameCell: UICollectionViewCell {
    
    static let identifier = "SimilarGameCell"
    
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    
    
    func configure(image: String, name: String) {

        gameImageView.setRounded(radius: 6)
        if image == "" {
            gameImageView.image = UIImage(named: "testBackImage_2")
        } else {
            gameImageView.setImage(from: image)
        }
        
        gameNameLabel.setLabel(text: name, font: .neoMedium(ofSize: 16))
        
    }
    
    
    
}
