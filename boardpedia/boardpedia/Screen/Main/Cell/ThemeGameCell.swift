//
//  ThemeGameCell.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/10.
//

import UIKit

class ThemeGameCell: UICollectionViewCell {
    
    // MARK: Variable Part
    
    static let identifier = "ThemeGameCell"
    
    // MARK: IBOutlet
    
    @IBOutlet weak var themeBackImageView: UIImageView!
    @IBOutlet weak var themeNameLabel: UILabel!
    
    // MARK: ContentView Default Set Function
    
    override func awakeFromNib() {
        
        self.contentView.backgroundColor = .gray
        self.themeNameLabel.setLabel(text: "추천 테마", color: .boardWhite, font: .neoBold(ofSize: 22))
        self.themeNameLabel.numberOfLines = 0
        contentView.setRounded(radius: 6)
        
    }
    
    // MARK: Data Set Function
    
    func configure(name: String, image: String) {
        self.themeNameLabel.text = name
        self.themeBackImageView.setImage(from: image)
    }

}
