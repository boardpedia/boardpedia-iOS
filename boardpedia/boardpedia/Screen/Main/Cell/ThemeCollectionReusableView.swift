//
//  ThemeCollectionReusableView.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/24.
//

import UIKit

class ThemeCollectionReusableView: UICollectionReusableView {
    
    // MARK: Variable Part
    
    var themeKeywordData: [KeywordData] = []
 
    // MARK: IBOutlet
    
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var themeTitleLabel: UILabel!
    
    @IBOutlet weak var keywordCollectionView: UICollectionView!
    
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    // MARK: ContentView Default Set Function
    
    override func awakeFromNib() {
        
        infoLabel.setLabel(text: "", color: .boardWhite, font: .neoMedium(ofSize: 17))
        themeTitleLabel.setLabel(text: "", color: .boardWhite, font: .neoBold(ofSize: 24))
        themeTitleLabel.numberOfLines = 0
        keywordCollectionView.delegate = self
        keywordCollectionView.dataSource = self
        keywordCollectionView.backgroundColor = .none
        
        let layout = keywordCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .vertical
        
        let item1 = KeywordData(keyword: "스피드")
        let item2 = KeywordData(keyword: "파티")
        let item3 = KeywordData(keyword: "즐거운")
        
        themeKeywordData.append(contentsOf: [item1,item2,item3])
        
    }
    
    func setTheme(info: String, title: String) {
        infoLabel.text = info
        themeTitleLabel.text = title
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout

extension ThemeCollectionReusableView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 한 아이템의 크기
        
        return CGSize(width: 36, height: 36)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // 아이템간의 간격
        
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // collectionView와 View 간의 간격
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    
}

// MARK: UICollectionViewDataSource

extension ThemeCollectionReusableView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return themeKeywordData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeKeywordCell.identifier, for: indexPath) as? ThemeKeywordCell else {
            return UICollectionViewCell()
        }
        cell.configure(title: themeKeywordData[indexPath.row].keyword)
    
        return cell
    }
    
    
}

