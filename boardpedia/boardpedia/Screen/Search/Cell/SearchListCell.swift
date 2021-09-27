//
//  SearchListCell.swift
//  boardpedia
//
//  Created by 김민희 on 2021/09/26.
//

import UIKit

class SearchListCell: UITableViewCell {
    
    static let identifier = "SearchListCell"

    @IBOutlet weak var searchLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        searchLabel.setLabel(text: "", font: .neoMedium(ofSize: 17))
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
