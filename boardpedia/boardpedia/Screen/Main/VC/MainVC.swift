//
//  ViewController.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/06.
//

import UIKit

class MainVC: UIViewController {
    
    // MARK: Variable Part
    
    var firstHeaderData: [gameDate] = []

    // MARK: IBOutlet
    
    @IBOutlet weak var seachButton: UIButton!
    @IBOutlet weak var firstHeaderLabel: UILabel!
    @IBOutlet weak var trandingGameCollectionView: UICollectionView!
    
    // MARK: IBAction
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setCollectionView()
        // Do any additional setup after loading the view.
    }

}

// MARK: Extension

extension MainVC {
    
    // MARK: View Style Function
    
    func setView() {
        
        seachButton.setButton(text: "원하는 보드게임을 찾아보세요!", color : .boardGray40, font: .neoMedium(ofSize: 17), backgroundColor: .boardGray)
        seachButton.setRounded(radius: 6)
        seachButton.titleEdgeInsets  = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        
        firstHeaderLabel.setLabel(text: "Now! 트렌딩 게임", font: .neoSemiBold(ofSize: 20))
        
        if let text = firstHeaderLabel.text {
            // 앞부분만 폰트와 컬러를 다르게 설정
            
            let attributedStr = NSMutableAttributedString(string: text)
            
//            attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: UIFont.threeLight(size: 14), range: (text as NSString).range(of: "Now!"))
            attributedStr.addAttribute(.foregroundColor, value: UIColor.boardOrange, range: (text as NSString).range(of: "Now!"))

            firstHeaderLabel.attributedText = attributedStr
        }
        
    }
    
    // MARK: CollectionView Style Function
    
    func setCollectionView() {
        
        // Test Data (서버 연결 전)
        let item1 = gameDate(gameImage: "", gameName: "보드게임 이름이 길면 어떨까요~", gameExplain: "만약에 설명이 길어지면 어떻게 될까요? 저는 궁금해요 선생님~")
        let item2 = gameDate(gameImage: "", gameName: "할리갈리", gameExplain: "할리갈리 해볼리?")
        let item3 = gameDate(gameImage: "", gameName: "루미큐브", gameExplain: "루미큐브 해보큐?")
        firstHeaderData.append(contentsOf: [item1,item2,item3])
        
        trandingGameCollectionView.delegate = self
        trandingGameCollectionView.dataSource = self
        
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension MainVC: UICollectionViewDelegateFlowLayout {
    // CollectionView 크기 잡기
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 한 아이템의 크기
        
        let itemWidth = 160/375 * self.view.frame.width
        return CGSize(width: itemWidth, height: collectionView.layer.frame.height)
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

extension MainVC: UICollectionViewDataSource {
    // CollectionView 데이터 넣기
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return firstHeaderData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: trandingGameCell.identifier, for: indexPath) as? trandingGameCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(name: firstHeaderData[indexPath.row].gameName, explain: firstHeaderData[indexPath.row].gameExplain)
        
        
        
        return cell
    }
    
}
