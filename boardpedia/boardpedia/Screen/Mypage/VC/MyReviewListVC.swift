//
//  MyReviewListVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/12.
//

import UIKit

class MyReviewListVC: UIViewController {
    
    // MARK: Variable Part
    
    var myReviewData: [MyReviewData] = []
    
    @IBOutlet weak var MyReviewListCollectionView: UICollectionView!
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MyReviewListCollectionView.delegate = self
        MyReviewListCollectionView.dataSource = self
        MyReviewListCollectionView.backgroundColor = .boardGray
        setResultCollectionView()
        // Do any additional setup after loading the view.
    }
    
    func setResultCollectionView() {
        
        // Test Data (서버 연결 전)
        let item1 = MyReviewData(gameImage: "testImage", gameName: "할리갈리 디럭스", firstKeyword: "스피드", secondKeyword: "꿀잼보장", star: 5)
        let item2 = MyReviewData(gameImage: "testBackImage_2", gameName: "미니미", firstKeyword: "김민희", secondKeyword: "24살", star: 4)
        let item3 = MyReviewData(gameImage: "testBackImage_1", gameName: "보드피디아", firstKeyword: "귀요미", secondKeyword: "3명", star: 3.5)
        myReviewData.append(contentsOf: [item1,item2,item3,item1,item2,item3])
        
    }
}


// MARK: UICollectionViewDelegateFlowLayout

extension MyReviewListVC: UICollectionViewDelegateFlowLayout {
    // CollectionView 크기 잡기
    
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
        
        return UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
        
    }
    
}

// MARK: UICollectionViewDataSource

extension MyReviewListVC: UICollectionViewDataSource {
    // CollectionView 데이터 넣기
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return myReviewData.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyReviewCell.identifier, for: indexPath) as? MyReviewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(image: myReviewData[indexPath.row].gameImage, name: myReviewData[indexPath.row].gameName, first: myReviewData[indexPath.row].firstKeyword, second: myReviewData[indexPath.row].secondKeyword, star: myReviewData[indexPath.row].star)
        return cell
        
    }
    
}
