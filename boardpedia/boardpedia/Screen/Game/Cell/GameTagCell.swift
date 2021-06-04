//
//  GameTagCell.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/31.
//

import UIKit

class GameTagCell: UICollectionViewCell {
    
    static let identifier = "GameTagCell"
    
    @IBOutlet weak var tagLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tagLabel.setLabel(text: "", color: .boardOrange, font: .neoMedium(ofSize: 15))
        
        self.contentView.setBorder(borderColor: .boardOrange, borderWidth: 1)
        self.contentView.setRounded(radius: 13)
    }
    
    
}
