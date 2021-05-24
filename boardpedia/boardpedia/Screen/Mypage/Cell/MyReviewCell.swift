//
//  MyReviewCell.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/13.
//

import UIKit

class MyReviewCell: UITableViewCell {

    static let identifier = "MyReviewCell"
    
    @IBOutlet weak var seperateView: UIView!
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var firstKeywordLabel: UILabel!
    @IBOutlet weak var secondKeywordLabel: UILabel!
    @IBOutlet var starImageView: [UIImageView]!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        defaultSettingView()
    }
    
    // MARK: Default View Setting Function
    
    func defaultSettingView() {
        
        self.contentView.backgroundColor = .boardGray
        seperateView.backgroundColor = .white
        seperateView.setRounded(radius: 6)
        gameImageView.setRounded(radius: 6)
        gameNameLabel.setLabel(text: "", font: .neoMedium(ofSize: 16))
        firstKeywordLabel.setBorder(borderColor: .boardOrange, borderWidth: 1)
        secondKeywordLabel.setBorder(borderColor: .boardOrange, borderWidth: 1)
        firstKeywordLabel.setLabel(text: "", color: .boardOrange, font: .neoMedium(ofSize: 15))
        secondKeywordLabel.setLabel(text: "", color: .boardOrange, font: .neoMedium(ofSize: 15))
    }
    
    
    
    // MARK: Data Set Function
    
    func configure(image: String, name: String, first: String, second: String, star: Float) {

        gameImageView.image = UIImage(named: image)
        gameNameLabel.text = name
        firstKeywordLabel.text = "\(first)"
        secondKeywordLabel.text = "\(second)"
        firstKeywordLabel.setRounded(radius: 11)
        secondKeywordLabel.setRounded(radius: 11)
        
        for i in Range(0...4) {
            if Float(i) < star {
                starImageView[i].image = UIImage(named: "icStar")
            } else {
                starImageView[i].image = UIImage(named: "icStarBlank")
            }
        }
        
    }

}
