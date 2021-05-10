//
//  RecentKeywordCell.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/11.
//

import UIKit

class RecentKeywordCell: UICollectionViewCell {
    
    // MARK: Variable Part
    
    static let identifier = "RecentKeywordCell"
    
    // MARK: IBOutlet
    
    @IBOutlet weak var keywordLabel: UILabel!
    
    // MARK: ContentView Default Set Function
    
    override func awakeFromNib() {
        keywordLabel.setLabel(text: "", color: .boardOrange, font: .neoMedium(ofSize: 16))
        self.contentView.setRounded(radius: self.contentView.frame.width/5)
        self.contentView.setBorder(borderColor: .boardOrange, borderWidth: 1)
    }
    
    // MARK: Data Set Function
    
    func configure(search: String) {
        keywordLabel.text = "\(search) X"
    }
}
