//
//  ThemeKeywordCell.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/25.
//

import UIKit

class ThemeKeywordCell: UICollectionViewCell {
    
    // MARK: Variable Part
    
    static let identifier = "ThemeKeywordCell"
    
    // MARK: IBOutlet
    
    @IBOutlet weak var keywordLabel: UILabel!
    
    // MARK: ContentView Default Set Function
    
    override func awakeFromNib() {
        keywordLabel.setLabel(text: "", color: .boardOrange, font: .neoMedium(ofSize: 15))
        self.contentView.backgroundColor = .white
        self.contentView.setBorder(borderColor: .boardOrange, borderWidth: 1)
        self.contentView.setRounded(radius: 14)
    }
    
    // MARK: Data Set Function
    
    func configure(title: String) {
        keywordLabel.text = title
    }
}
