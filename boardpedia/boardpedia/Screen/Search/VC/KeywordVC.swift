//
//  KeywordVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/11.
//

import UIKit

class KeywordVC: UIViewController {

    // MARK: Variable Part
    
    var recentKeywordData: [KeywordData] = []
    var topKeywordData: [TrendingGame] = []
    
    // MARK: IBOutlet
    
    @IBOutlet weak var recentKeywordView: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var recentKeywordCollectionView: UICollectionView!
    
    
    @IBOutlet weak var secondInfoLabel: UILabel!
    @IBOutlet weak var topKeywordCollectionView: UICollectionView!
    
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            // 동적 사이즈를 주기 위해 estimatedItemSize 를 사용했다. 대략적인 셀의 크기를 먼저 조정한 후에 셀이 나중에 AutoLayout 될 때, 셀의 크기가 변경된다면 그 값이 다시 UICollectionViewFlowLayout에 전달되어 최종 사이즈가 결정되게 된다.
        }
    }
    
    @IBOutlet weak var topCollectionLayout: UICollectionViewFlowLayout! {
        didSet {
            topCollectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    
    // MARK: IBAction
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        noKeyword()
        topKeywordSet()
    }
    
}

// MARK: Extension

extension KeywordVC {
    
    // MARK: View Style Function
    
    func setView() {
        infoLabel.setLabel(text: "최근 검색어", font: .neoBold(ofSize: 16))
        secondInfoLabel.setLabel(text: "많이 찾고 있어요!", font: .neoBold(ofSize: 16))
    }
    
    // MARK: No Recent Keyword Style Function
    
    func noKeyword() {
        // 최근 검색어가 없는 상황
        
        let noKeywordLabel = UILabel()
        self.view.addSubview(noKeywordLabel)
        noKeywordLabel.translatesAutoresizingMaskIntoConstraints = false
        noKeywordLabel.topAnchor.constraint(equalTo: self.infoLabel.bottomAnchor, constant: 20).isActive = true
        noKeywordLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 17).isActive = true
        
        noKeywordLabel.setLabel(text: "검색어가 아직 없어요!", color: .boardGray30, font: .neoMedium(ofSize: 17))
    }
    
    // MARK: Have Recent Keyword Style Function
    
    func haveKeyword() {
        // 최근 검색어가 있는 상황
        
        // Test Data (서버 연결 전)
        let item1 = KeywordData(keyword: "다함께 즐기는")
        let item2 = KeywordData(keyword: "루미큐브")
        let item3 = KeywordData(keyword: "보드피디아")
        
        recentKeywordData.append(contentsOf: [item1,item2,item3])
        
        let layout = recentKeywordCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        
        recentKeywordCollectionView.delegate = self
        recentKeywordCollectionView.dataSource = self
        
        // 모두 지우기 버튼 코드로 구현
        let removeButton = UIButton()
        self.view.addSubview(removeButton)
        
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        removeButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        removeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        removeButton.centerYAnchor.constraint(equalTo: self.infoLabel.centerYAnchor).isActive = true
        removeButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -0).isActive = true

        removeButton.setButton(text: "모두 지우기", color: .boardGray40, font: .neoSemiBold(ofSize: 16))
        
    }
    
    // MARK: Top Keyword Style Function
    
    func topKeywordSet() {
        
        let layout = topKeywordCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .vertical
        
        let customLayout = LeftAlignFlowLayout()
        topKeywordCollectionView.collectionViewLayout = customLayout
        customLayout.estimatedItemSize = CGSize(width: 41, height: 41)
        
        topKeywordCollectionView.delegate = self
        topKeywordCollectionView.dataSource = self
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout

extension KeywordVC: UICollectionViewDelegateFlowLayout {
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
        
        if collectionView == recentKeywordCollectionView {
            return 0
        } else {
            return 10
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // collectionView와 View 간의 간격
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        
    }
    
}

// MARK: UICollectionViewDataSource

extension KeywordVC: UICollectionViewDataSource {
    // CollectionView 데이터 넣기
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == recentKeywordCollectionView {
            return recentKeywordData.count
        } else {
            return topKeywordData.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == recentKeywordCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentKeywordCell.identifier, for: indexPath) as? RecentKeywordCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(search: recentKeywordData[indexPath.row].keyword)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopKeywordCell.identifier, for: indexPath) as? TopKeywordCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(search: topKeywordData[indexPath.row].name)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == topKeywordCollectionView {
            NotificationCenter.default.post(name: .clickKeyword, object: topKeywordData[indexPath.row].name)
        }
    }
    
}

