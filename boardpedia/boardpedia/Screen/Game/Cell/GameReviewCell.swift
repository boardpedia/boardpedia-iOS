//
//  GameReviewCell.swift
//  boardpedia
//
//  Created by 김민희 on 2021/06/03.
//

import UIKit

class GameReviewCell: UITableViewCell {
    
    static let identifier = "GameReviewCell"
    var tagArray: [String] = []
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nickLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var keywordCollectionView: UICollectionView!
    
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            // 동적 사이즈를 주기 위해 estimatedItemSize 를 사용했다. 대략적인 셀의 크기를 먼저 조정한 후에 셀이 나중에 AutoLayout 될 때, 셀의 크기가 변경된다면 그 값이 다시 UICollectionViewFlowLayout에 전달되어 최종 사이즈가 결정되게 된다.
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let layout = keywordCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .vertical
        
        keywordCollectionView.delegate = self
        keywordCollectionView.dataSource = self
        // Initialization code
    }
    
    func configure(nick: String, start: Double, keyword: [String], date: String, level: String) {
        
        nickLabel.setLabel(text: nick, font: .neoMedium(ofSize: 16))
        dateLabel.setLabel(text: date.recordTime(), color: .boardGray30, font: .neoMedium(ofSize: 14))
        profileImageView.image = UIImage(named: "profileImg")
        
        tagArray = keyword
        keywordCollectionView.reloadData()
        
        //[Review(reviewIdx: 2, star: 4, keyword: ["파티","심리"], createdAt: "2021-05-26 23:12:13", userIdx: 8, nickName: "보드진심녀", level: "보드신입생")])
        
        
        
    }

}

// MARK: UICollectionViewDelegateFlowLayout

extension GameReviewCell: UICollectionViewDelegateFlowLayout {
    // CollectionView 크기 잡기
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 한 아이템의 크기
        
        return CGSize(width: 78, height: 30)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // 아이템간의 간격
        
        return 10
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // collectionView와 View 간의 간격
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    
}

// MARK: UICollectionViewDataSource

extension GameReviewCell: UICollectionViewDataSource {
    // CollectionView 데이터 넣기
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return tagArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameTagCell.identifier, for: indexPath) as? GameTagCell else {
            return UICollectionViewCell()
        }
        
        cell.tagLabel.setLabel(text: "#\(tagArray[indexPath.row])", color: .boardGray40, font: .neoMedium(ofSize: 15))
        cell.contentView.layer.borderColor = UIColor.boardGray40.cgColor
        cell.contentView.setRounded(radius: 10)
        
        return cell
        
        
    }
    
}

