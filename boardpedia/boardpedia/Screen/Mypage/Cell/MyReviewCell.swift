//
//  MyReviewCell.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/13.
//

import UIKit

class MyReviewCell: UITableViewCell {

    static let identifier = "MyReviewCell"
    var keywordData: [String] = []
    
    @IBOutlet weak var seperateView: UIView!
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var keywordCollectionView: UICollectionView!
    @IBOutlet var starImageView: [UIImageView]!
    
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    
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

        let layout = keywordCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .vertical
        keywordCollectionView.delegate = self
        keywordCollectionView.dataSource = self
        keywordCollectionView.backgroundColor = .none
        
        let customLayout = LeftAlignFlowLayout()
        keywordCollectionView.collectionViewLayout = customLayout
        customLayout.estimatedItemSize = CGSize(width: 10, height: 20)
    }
    
    
    // MARK: Data Set Function
    
    func configure(image: String, name: String, keyword: [String], star: Double) {

        gameImageView.setImage(from: image)
        gameNameLabel.text = name
        keywordData = keyword
        keywordCollectionView.reloadData()
        
        for i in Range(0...4) {
            if Double(i) < star {
                starImageView[i].image = UIImage(named: "icStar")
            } else {
                starImageView[i].image = UIImage(named: "icStarBlank")
            }
        }
        
    }

}

// MARK: UICollectionViewDelegateFlowLayout

extension MyReviewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 한 아이템의 크기
        
        return CGSize(width: 36, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // 아이템간의 간격
        
        return 0
        
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

extension MyReviewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return keywordData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeKeywordCell.identifier, for: indexPath) as? ThemeKeywordCell else {
            return UICollectionViewCell()
        }
        cell.configure(title: keywordData[indexPath.row])
    
        return cell
    }
    
    
}


