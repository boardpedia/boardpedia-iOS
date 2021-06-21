//
//  SearchResultCell.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/11.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    // MARK: Variable Part
    
    static let identifier = "SearchResultCell"
    var cellDelegate: BookmarkCellDelegate?
    var cellIndex : IndexPath?
    
    // MARK: IBOutlet
    
    @IBOutlet weak var boardImageView: UIImageView!
    @IBOutlet weak var boardGameNameLabel: UILabel!
    @IBOutlet weak var boardGameInfoLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var gameValueLabel: UILabel!
    
    @IBAction func bookmarkDidTap(_ sender: Any) {
        // 북마크 버튼 클릭 시 이미지 변경을 위해 index 전송
        
        cellDelegate?.BookmarkCellGiveIndex(self, didClickedIndex: cellIndex?.row ?? 0)
        
    }
    
    
    
    // MARK: ContentView Default Set Function
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.backgroundColor = .boardWhite
        self.contentView.setRounded(radius: 6)
        
        boardGameNameLabel.numberOfLines = 0
        boardGameInfoLabel.numberOfLines = 0
        boardImageView.setRounded(radius: 6)
    }
    
    // MARK: Data Set Function
    func configure(image: String, name: String, info: String, star: Double, save: Int) {

        if image == "" {
            boardImageView.image = UIImage(named: "testBackImage_2")
        } else {
            boardImageView.setImage(from: image)
        }
        boardGameNameLabel.setLabel(text: name, font: .neoMedium(ofSize: 16))
        boardGameInfoLabel.setLabel(text: info, color: .boardGray50, font: .neoRegular(ofSize: 13))
        gameValueLabel.setLabel(text: "별점 \(star) / 저장 \(save)회", color: .boardGray40, font: .neoMedium(ofSize: 12))
        
    }
}

protocol BookmarkCellDelegate {
    func BookmarkCellGiveIndex(_ cell: UICollectionViewCell, didClickedIndex value:Int)
}
