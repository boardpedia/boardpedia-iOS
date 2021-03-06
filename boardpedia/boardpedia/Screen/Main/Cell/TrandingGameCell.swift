//
//  trandingGameCell.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/08.
//

import UIKit

class TrandingGameCell: UICollectionViewCell {
    
    // MARK: Variable Part
    
    static let identifier = "TrandingGameCell"
    var cellDelegate: BookmarkCellDelegate?
    var cellIndex: IndexPath?
    var impactFeedbackGenerator: UIImpactFeedbackGenerator?
    
    // MARK: IBOutlet
    
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameExplainLabel: UILabel!
    
    // MARK: IBAction
    
    @IBAction func bookmarkDidTap(_ sender: Any) {
        
        cellDelegate?.BookmarkCellGiveIndex(self, didClickedIndex: cellIndex?.row ?? 0)
        self.impactFeedbackGenerator?.impactOccurred()
    }
    
    // MARK: ContentView Default Set Function
    
    override func awakeFromNib() {
        gameNameLabel.setLabel(text: "게임 이름", font: .neoMedium(ofSize: 16))
        gameExplainLabel.setLabel(text: "보드게임 한 줄 설명", color: .boardGray50, font: .neoRegular(ofSize: 13))
        gameImageView.setRounded(radius: 6)
        self.impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    }
    
    // MARK: Data Set Function
    
    func configure(name: String, explain: String) {
        gameNameLabel.text = name
        gameExplainLabel.text = explain
    }
    
    // MARK: Image Set Function
    
    func setImage(imageURL: String) {
        gameImageView.setImage(from: imageURL)
    }
    
}
