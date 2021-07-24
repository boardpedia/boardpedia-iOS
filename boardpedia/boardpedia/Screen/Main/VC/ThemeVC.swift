//
//  ThemeVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/24.
//

import UIKit

class ThemeVC: UIViewController {
    
    // MARK: Variable Part
    
    var searchResultData: [SearchResultData] = []
    var themeIdx: Int?
    
    // MARK: IBOutlet
    
    @IBOutlet weak var themeListCollectionView: UICollectionView!
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setResultCollectionView()
    }
    
    
}

// MARK: Extension

extension ThemeVC {
    
    // MARK: Result Data Style Function
    
    func setResultCollectionView() {
        
        themeListCollectionView.delegate = self
        themeListCollectionView.dataSource = self
        themeListCollectionView.backgroundColor = .boardGray
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension ThemeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 한 아이템의 크기
        
        let itemWidth = self.view.frame.width - 32
        return CGSize(width: itemWidth, height: 120/343 * itemWidth)
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
        
        return UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        
    }
    
}

// MARK: UICollectionViewDataSource

extension ThemeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResultData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeGameListCell.identifier, for: indexPath) as? ThemeGameListCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(image: searchResultData[indexPath.row].gameImage, name: searchResultData[indexPath.row].gameName, info: searchResultData[indexPath.row].gameInfo, star: searchResultData[indexPath.row].startNumber, save: searchResultData[indexPath.row].saveNumber)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // collectionView 헤더 설정
        
        let headerview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ThemeCollectionReusableView", for: indexPath) as! ThemeCollectionReusableView
        
        headerview.setTheme(info: "✋은 👀보다 빠르다", title: "내가 이 구역 최고 브레인!")
        return headerview
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // collectionView header 동적 높이 설정
        
        return CGSize(width: collectionView.frame.width, height: 285/375 * collectionView.frame.width)
    }
    
}
