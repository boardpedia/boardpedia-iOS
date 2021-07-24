//
//  ThemeVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/24.
//

import UIKit

class ThemeVC: UIViewController {
    
    // MARK: Variable Part
    
    var themeDetailData: ThemeDetailData?
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
        
        if let token = UserDefaults.standard.string(forKey: "UserToken"),
           let index = themeIdx {
            // 테마 받아오는 서버 연결
            
            APIService.shared.todayThemeDetail(token, index) { [self] result in
                switch result {
                
                case .success(let data):
                    themeDetailData = data
                    themeListCollectionView.reloadData()
                    // 데이터 화면에 뿌려주기
                    
                case .failure(let error):
                    print(error)
                    
                }
                
            }
            
        }
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
        
        if let data = themeDetailData?.themeGame {
            return data.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeGameListCell.identifier, for: indexPath) as? ThemeGameListCell else {
            return UICollectionViewCell()
        }
        
        if let data = themeDetailData?.themeGame[indexPath.row] {
            cell.configure(image: data.imageURL, name: data.name, info: data.intro, star: data.star, save: data.saveCount)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // collectionView 헤더 설정
        
        let headerview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ThemeCollectionReusableView", for: indexPath) as! ThemeCollectionReusableView
        
        if let data = themeDetailData?.themes[0] {
            headerview.setTheme(info: data.detail, title: data.name, back: data.imageURL)
        }
        
        return headerview
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // collectionView header 동적 높이 설정
        
        return CGSize(width: collectionView.frame.width, height: 285/375 * collectionView.frame.width)
    }
    
}
