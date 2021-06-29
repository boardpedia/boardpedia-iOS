//
//  MySaveListCell.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/12.
//

import UIKit

class MySaveListCell: UICollectionViewCell {
    
    // MARK: Variable Part
    
    static let identifier = "MySaveListCell"
    
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameInfoLabel: UILabel!
    
    // MARK: ContentView Default Set Function
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        gameImageView.setRounded(radius: 6)
        bookmarkButton.setImage(UIImage(named: "icStorageSelected"), for: .normal)
        gameNameLabel.setLabel(text: "", font: .neoMedium(ofSize: 15))
        gameInfoLabel.setLabel(text: "", color: .boardGray50, font: .neoRegular(ofSize: 12))
    }
    
    // MARK: Data Set Function
    
    func configure(image: String, name: String, info: String) {
        
        gameImageView.setImage(from: image)
        gameNameLabel.text = name
        gameInfoLabel.text = info
        
    }
    
    
}
