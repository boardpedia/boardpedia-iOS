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
        self.contentView.setRounded(radius: 10)
    }
}
