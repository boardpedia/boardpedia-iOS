//
//  GameCollectionCell.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/28.
//

import UIKit

class GameCollectionCell: UICollectionViewCell {
    
    // MARK: Variable Part
    
    static let identifier = "GameCollectionCell"
    var cellDelegate: BookmarkCellDelegate?
    var cellIndex: IndexPath?
    var impactFeedbackGenerator: UIImpactFeedbackGenerator?
    
    // MARK: IBOutlet
    
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameInfoLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var gameValueLabel: UILabel!
    
    // MARK: IBAction
    
    @IBAction func bookmarkButtonDidTap(_ sender: Any) {
        
        cellDelegate?.BookmarkCellGiveIndex(self, didClickedIndex: cellIndex?.row ?? 0)
        self.impactFeedbackGenerator?.impactOccurred()
        
    }
    
    // MARK: ContentView Default Set Function
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
        
        self.impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        
        self.contentView.backgroundColor = .boardWhite
        self.contentView.setRounded(radius: 6)
        
        gameNameLabel.numberOfLines = 0
        gameInfoLabel.numberOfLines = 0
        gameImageView.setRounded(radius: 6)
    }
    
    // MARK: Data Set Function
    
    func configure(image: String, name: String, info: String, star: Double, save: Int) {

        gameImageView.setImage(from: image)
        gameNameLabel.setLabel(text: name, font: .neoMedium(ofSize: 16))
        gameInfoLabel.setLabel(text: info, color: .boardGray50, font: .neoRegular(ofSize: 13))
        gameValueLabel.setLabel(text: "별점 \(star) / 저장 \(save)회", color: .boardGray40, font: .neoMedium(ofSize: 12))
        
    }

}
