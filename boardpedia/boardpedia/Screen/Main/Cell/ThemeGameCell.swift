//
//  ThemeGameCell.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/10.
//

import UIKit

class ThemeGameCell: UICollectionViewCell {
    
    // MARK: Variable Part
    
    static let identifier = "ThemeGameCell"
    var themeKeywordData: [String] = []
    
    // MARK: IBOutlet
    
    @IBOutlet weak var themeBackImageView: UIImageView!
    @IBOutlet weak var themeNameLabel: UILabel!
    @IBOutlet weak var keywordCollectionView: UICollectionView!
    
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    // MARK: ContentView Default Set Function
    
    override func awakeFromNib() {
        
        let layout = keywordCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .vertical
        keywordCollectionView.delegate = self
        keywordCollectionView.dataSource = self
        keywordCollectionView.backgroundColor = .none
        
        let customLayout = LeftAlignFlowLayout()
        keywordCollectionView.collectionViewLayout = customLayout
        customLayout.estimatedItemSize = CGSize(width: 41, height: 41)
        
        
        self.contentView.backgroundColor = .gray
        self.themeNameLabel.setLabel(text: "추천 테마", color: .boardWhite, font: .neoBold(ofSize: 22))
        self.themeNameLabel.numberOfLines = 0
        contentView.setRounded(radius: 6)
        
    }
    
    // MARK: Data Set Function
    
    func configure(name: String, image: String, keyword: [String]) {
        self.themeNameLabel.text = name
        self.themeBackImageView.setImage(from: image)
        themeKeywordData = keyword
        keywordCollectionView.reloadData()
    }

}


// MARK: UICollectionViewDelegateFlowLayout

extension ThemeGameCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 한 아이템의 크기
        
        return CGSize(width: 36, height: 36)
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

extension ThemeGameCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return themeKeywordData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeKeywordCell.identifier, for: indexPath) as? ThemeKeywordCell else {
            return UICollectionViewCell()
        }
        cell.configure(title: themeKeywordData[indexPath.row])
    
        return cell
    }
    
    
}


