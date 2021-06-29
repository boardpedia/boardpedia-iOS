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
    
    func nickConfigure(level: String, login: Bool) {
        
        keywordLabel.text = level
        self.contentView.setRounded(radius: 12)
        
        if login {
            // 로그인 유저일 때
            
            self.contentView.backgroundColor = UIColor(red: 1.0, green: 119.0 / 255.0, blue: 72.0 / 255.0, alpha: 0.1)
            keywordLabel.textColor = .boardOrange
            self.contentView.setBorder(borderColor: .boardOrange, borderWidth: 1)
            
            
        } else {
            // 비로그인 유저일 때
            
            keywordLabel.textColor = .boardGray30
            self.contentView.backgroundColor = .boardGray
            self.contentView.setBorder(borderColor: .boardGray30, borderWidth: 1)
        }
        
        
        
    }
}
