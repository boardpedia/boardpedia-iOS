//
//  GameReviewCell.swift
//  boardpedia
//
//  Created by 김민희 on 2021/06/03.
//

import UIKit

class GameReviewCell: UITableViewCell {
    
    static let identifier = "GameReviewCell"
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nickLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var keywordCollectionView: UICollectionViewCell!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(nick: String, start: Double, keyword: [String], date: String, level: String) {
        
        nickLabel.setLabel(text: nick, font: .neoMedium(ofSize: 16))
        dateLabel.setLabel(text: date, color: .boardGray30, font: .neoMedium(ofSize: 14))
        profileImageView.image = UIImage(named: "profileImg")
        
        //[Review(reviewIdx: 2, star: 4, keyword: ["파티","심리"], createdAt: "2021-05-26 23:12:13", userIdx: 8, nickName: "보드진심녀", level: "보드신입생")])
        
        
        
    }

}
