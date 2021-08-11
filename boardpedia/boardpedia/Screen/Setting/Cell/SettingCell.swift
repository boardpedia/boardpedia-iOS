//
//  SettingCell.swift
//  boardpedia
//
//  Created by Hailey on 2021/08/10.
//

import UIKit

class SettingCell: UITableViewCell {

    static let identifier = "SettingCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = .neoMedium(ofSize: 16)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
