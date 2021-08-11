//
//  KeywordFilterVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/08/07.
//

import UIKit

class KeywordFilterVC: UIViewController {
    
    // MARK: Variable Part

    var keyword: [String] = ["간단한", "클래식", "롤플레이", "전략", "심리", "스피드", "파티", "스릴만점", "모험", "운빨", "주사위", "카드", "견제", "협상", "퍼즐", "팀전"]
    var keywordSelected: [Bool] = Array(repeating: false, count: 16)
    var keywordFilterAction : (([String]) -> Void)? // closer 변수
    var keywordData: [String]?
    
    // MARK: IBOutlet
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var keywordCollectionView: UICollectionView!
    
    @IBOutlet weak var keywordCollectionLayout: UICollectionViewFlowLayout! {
        didSet {
            keywordCollectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let keywordData = keywordData {
            for k in keywordData {
                if let index = keyword.index(of: k) {
                    keywordSelected[index] = true
                }
                
            }
        }
        
        setView()
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 뷰 클릭 시 뷰 내리기
        
        self.dismiss(animated: true)
        
        keywordData = []
        // 초기화
        
        for i in 0..<keyword.count {
            if keywordSelected[i] {
                // 선택된것이라면
                
                keywordData?.append(keyword[i])
                // 더해주기
            }
        }
        
        guard let keywordFilterAction = keywordFilterAction else {
            return
        }
        
        if let keywordData = keywordData {
            keywordFilterAction(keywordData)
            // 전달받은 action 실행
        }
        
    }

}

// MARK: Extension

extension KeywordFilterVC {
    
    func setView() {
        
        keywordCollectionView.delegate = self
        keywordCollectionView.dataSource = self

        let customLayout = LeftAlignFlowLayout()
        keywordCollectionView.collectionViewLayout = customLayout
        customLayout.estimatedItemSize = CGSize(width: 40, height: 20)
        
        popupView.layer.cornerRadius = 14
        popupView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension KeywordFilterVC: UICollectionViewDelegateFlowLayout {
    // CollectionView 크기 잡기
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 한 아이템의 크기
        
        return CGSize(width: 67, height: 28)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 15
        
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

extension KeywordFilterVC: UICollectionViewDataSource {
    // CollectionView 데이터 넣기
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return keyword.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeKeywordCell.identifier, for: indexPath) as? ThemeKeywordCell else {
            return UICollectionViewCell()
        }
        
        cell.keywordLabel.text = keyword[indexPath.row]
        
        if keywordSelected[indexPath.row] {
            // 선택되어있다면?
            cell.keywordLabel.textColor = .white
            cell.contentView.backgroundColor = .boardOrange
        } else {
            // 미선택이라면?
            
            cell.keywordLabel.textColor = .boardOrange
            cell.contentView.backgroundColor = .white
            
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if keywordSelected[indexPath.row] {
            // 선택된 애를 선택했다면 -> 미선택으로 변경
            
            keywordSelected[indexPath.row] = !keywordSelected[indexPath.row]
            
        } else {
            // 미선택된애를 선택했다면 -> 선택으로 변경
            
            if keywordSelected.filter({ $0 == true }).count < 3 {
                // 아직 3개가 선택되지 않았다면
                
                keywordSelected[indexPath.row] = !keywordSelected[indexPath.row]
                
                
            } else {
                showToast(message: "키워드는 3개까지 선택 가능해요", width: 300, bottomY: 50)
            }
        }
        keywordCollectionView.reloadData()
    }
    
}
