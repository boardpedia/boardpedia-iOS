//
//  FilterCell.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/28.
//

import UIKit

class FilterCell: UICollectionViewCell {
    
    // MARK: Variable Part
    
    static let identifier = "FilterCell"
    
    // MARK: IBOutlet
    
    @IBOutlet weak var filterLabel: UILabel!
    
    // MARK: ContentView Default Set Function
    
    override func awakeFromNib() {
        super.awakeFromNib()
        filterLabel.setLabel(text: "", color: .boardGray50, font: .neoMedium(ofSize: 16))
        self.contentView.backgroundColor = UIColor(red: 245.0 / 255.0, green: 245.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0)
        self.contentView.setRounded(radius: 10)
    }
}
