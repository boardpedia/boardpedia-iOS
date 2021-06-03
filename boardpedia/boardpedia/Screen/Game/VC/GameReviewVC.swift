//
//  GameReviewVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/06/03.
//

import UIKit

class GameReviewVC: UIViewController {

    var reviewData: ReviewData?
    var keyword: [String]?
    
    @IBOutlet weak var totalView: UIView!
    
    @IBOutlet weak var averageStarLabel: UILabel!
    @IBOutlet weak var topKeywordCollectionView: UICollectionView!

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var writeButton: UIButton!
    
    @IBOutlet weak var reviewCollectionView: UITableView!
    
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            // 동적 사이즈를 주기 위해 estimatedItemSize 를 사용했다. 대략적인 셀의 크기를 먼저 조정한 후에 셀이 나중에 AutoLayout 될 때, 셀의 크기가 변경된다면 그 값이 다시 UICollectionViewFlowLayout에 전달되어 최종 사이즈가 결정되게 된다.
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setData()
    
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        
        self.topKeywordCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        if let data = reviewData {
            if data.reviewInfo.topKeywords.count > 2 {
                
                self.topKeywordCollectionView.heightAnchor.constraint(equalToConstant: 70).isActive = true
                
            } else {
                
                self.topKeywordCollectionView.heightAnchor.constraint(equalToConstant: 30).isActive = true
            }
        }
        
    }

}

extension GameReviewVC {
    
    func setView() {
        
        self.totalView.setRounded(radius: 6)
        
        writeButton.setButton(text: "후기쓰기", color: .boardOrange, font: .neoBold(ofSize: 16), backgroundColor: .clear)
        
        let layout = topKeywordCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        
        
        // topKeywordCollectionView cell 가운데 정렬
        let columnLayout = UICollectionViewCenterLayout()
        columnLayout.estimatedItemSize = CGSize(width: 140, height: 40)
        topKeywordCollectionView.collectionViewLayout = columnLayout
    
        
        topKeywordCollectionView.delegate = self
        topKeywordCollectionView.dataSource = self
        
        topKeywordCollectionView.backgroundColor = .clear
    }
    
    func setData() {
        
        let item = ReviewData(reviewInfo: ReviewInfo(averageStar: 3.5, topKeywords: ["파티", "심리", "하하호호"]), reviews: [Review(reviewIdx: 2, star: 4, keyword: ["파티","심리"], createdAt: "2021-05-26 23:12:13", userIdx: 8, nickName: "보드진심녀", level: "보드신입생")])
        
        reviewData = item
        
        if let data = reviewData {
            
            averageStarLabel.setLabel(text: "\(data.reviewInfo.averageStar)", font: .neoSemiBold(ofSize: 33))
            keyword = data.reviewInfo.topKeywords
            topKeywordCollectionView.reloadData()
            
            countLabel.setLabel(text: "후기 \(data.reviewInfo.topKeywords.count)개", font: .neoMedium(ofSize: 16))
            
        }
        
    }
    
}


// MARK: UICollectionViewDelegateFlowLayout

extension GameReviewVC: UICollectionViewDelegateFlowLayout {
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

extension GameReviewVC: UICollectionViewDataSource {
    // CollectionView 데이터 넣기
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let data = reviewData {
            return data.reviewInfo.topKeywords.count
        } else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameTagCell.identifier, for: indexPath) as? GameTagCell else {
            return UICollectionViewCell()
        }
        
        if let data = reviewData {
            cell.tagLabel.text = "# \(data.reviewInfo.topKeywords[indexPath.row])"
        }
        
        
        return cell
        
        
    }
    
}
