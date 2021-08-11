//
//  LevelCell.swift
//  boardpedia
//
//  Created by 김민희 on 2021/08/07.
//

import UIKit

class LevelCell: UITableViewCell {

    static let identifier = "LevelCell"
    
    @IBOutlet weak var levelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }


}
