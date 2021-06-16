//
//  ViewController.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/06.
//

import UIKit

class MainVC: UIViewController {
    
    // MARK: Variable Part
    
    var trendingData: [TrendingGame] = []
    var secondHeaderData: [ThemeData] = []

    // MARK: IBOutlet
    
    @IBOutlet weak var seachButton: UIButton!
    @IBOutlet weak var firstHeaderLabel: UILabel!
    @IBOutlet weak var trandingGameCollectionView: UICollectionView!
    
    @IBOutlet weak var secondHeaderLabel: UILabel!
    @IBOutlet weak var explainLabel: UILabel!
    
    @IBOutlet weak var bestThemeButton: UIButton!
    @IBOutlet weak var bestThemeNameLabel: UILabel!
    @IBOutlet weak var themeGameCollectionView: UICollectionView!
    
    @IBOutlet weak var instagramButton: UIButton!
    @IBOutlet weak var stackFirstLabel: UILabel!
    @IBOutlet weak var stackSecondLabel: UILabel!
    
    // MARK: IBAction
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setCollectionView()
       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        trendingGameData(jwt: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWR4Ijo4LCJpYXQiOjE2MjM4MjEwNjksImV4cCI6MTYyNDQyNTg2OSwiaXNzIjoiYm9hcmRwZWRpYSJ9.Jy6KDtE2fRvb4Yb0MfcVdSJ7JofGpoH2t7gtt3FgQHI")
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
        
        secondHeaderLabel.setLabel(text: "오늘의 추천 테마", font: .neoSemiBold(ofSize: 20))
        explainLabel.setLabel(text: "보드게임 진심러들이 고른 진짜 중 진짜!", color: .boardGray50, font: .neoMedium(ofSize: 15))
        
        bestThemeButton.setRounded(radius: 6)
        bestThemeNameLabel.numberOfLines = 0
        
        instagramButton.setRounded(radius: 6)
        stackFirstLabel.setLabel(text: "보드피디아\n100% 사용하는 방법!", color: .boardWhite, font: .neoBold(ofSize: 17))
        stackFirstLabel.numberOfLines = 0
        stackFirstLabel.lineSetting(lineSpacing: 5)
        stackFirstLabel.textAlignment = .left
        
        if let text = stackFirstLabel.text {
            // 앞부분만 폰트와 컬러를 다르게 설정
            
            let attributedStr = NSMutableAttributedString(string: text)
            
            attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: UIFont.neoSemiBold(ofSize: 17), range: (text as NSString).range(of: "100% 사용하는 방법!"))

            stackFirstLabel.attributedText = attributedStr
        }
        
        stackSecondLabel.setLabel(text: "보드피디아 제작자가 알려드려요", color: .boardWhite70, font: .neoMedium(ofSize: 14))
        
    }
    
    // MARK: CollectionView Style Function
    
    func setCollectionView() {
        
        trandingGameCollectionView.delegate = self
        trandingGameCollectionView.dataSource = self
        
        // Test Data (서버 연결 전)
        let themeItem1 = ThemeData(themeImage: "testBackImage_1", themeName: "내가 이 구역 최고 브레인!")
        let themeItem2 = ThemeData(themeImage: "testBackImage_2", themeName: "보드게임\n5분 컷!")
        let themeItem3 = ThemeData(themeImage: "testBackImage_2", themeName: "보드게임\n5분 컷!")
        let themeItem4 = ThemeData(themeImage: "testBackImage_2", themeName: "보드게임\n5분 컷!")
        let themeItem5 = ThemeData(themeImage: "testBackImage_2", themeName: "보드게임\n5분 컷!")
        let themeItem6 = ThemeData(themeImage: "testBackImage_2", themeName: "보드게임\n5분 컷!")
        let themeItem7 = ThemeData(themeImage: "testBackImage_2", themeName: "보드게임\n5분 컷!")
        let themeItem8 = ThemeData(themeImage: "testBackImage_2", themeName: "보드게임\n5분 컷!")
        let themeItem9 = ThemeData(themeImage: "testBackImage_2", themeName: "보드게임\n5분 컷!")
        secondHeaderData.append(contentsOf: [themeItem1,themeItem2,themeItem3,themeItem4,themeItem5,themeItem6,themeItem7,themeItem8,themeItem9])
        
        bestThemeNameLabel.setLabel(text: secondHeaderData[0].themeName, color: .boardWhite, font: .neoBold(ofSize: 24))
        bestThemeButton.setImage(UIImage(named: secondHeaderData[0].themeImage), for: .normal)
        
        themeGameCollectionView.delegate = self
        themeGameCollectionView.dataSource = self
        
    }
    
    // MARK: TrendingGame Network Connect
    
    func trendingGameData(jwt: String) {
        
        APIService.shared.trending(jwt) { [self] result in
            switch result {
            
            case .success(let data):
                
                trendingData = data
                trandingGameCollectionView.reloadData()
                
            case .failure(let error):
                print(error)
            
            }
            
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension MainVC: UICollectionViewDelegateFlowLayout {
    // CollectionView 크기 잡기
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 한 아이템의 크기
        
        if collectionView == trandingGameCollectionView {
            let itemWidth = 160/375 * self.view.frame.width
            return CGSize(width: itemWidth, height: collectionView.layer.frame.height)
        } else {
            let itemWidth = self.themeGameCollectionView.frame.width / 2 - 7.5
            return CGSize(width: itemWidth, height: itemWidth)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // 아이템간의 간격
        
        if collectionView == trandingGameCollectionView {
            return 10
        } else {
            return 15
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // collectionView와 View 간의 간격
        
        if collectionView == trandingGameCollectionView {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        } else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
    }
    
}

// MARK: UICollectionViewDataSource

extension MainVC: UICollectionViewDataSource {
    // CollectionView 데이터 넣기
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == trandingGameCollectionView {
            return trendingData.count
        } else {
            return 8
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == trandingGameCollectionView {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrandingGameCell.identifier, for: indexPath) as? TrandingGameCell else {
                return UICollectionViewCell()
            }
            
            cell.cellDelegate = self
            cell.cellIndex = indexPath
            
            cell.configure(name: trendingData[indexPath.row].name, explain: trendingData[indexPath.row].intro)
            
            if trendingData[indexPath.row].imageURL != "" {
                cell.setImage(imageURL: trendingData[indexPath.row].imageURL)
            } else {
                cell.gameImageView.image = UIImage(named: "testImage")
            }
            
            
            if trendingData[indexPath.row].saved == 0 {
                cell.bookmarkButton.setImage(UIImage(named: "icStorageUnselected"), for: .normal)
            } else {
                cell.bookmarkButton.setImage(UIImage(named: "icStorageSelected"), for: .normal)
            }
            
            return cell
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeGameCell.identifier, for: indexPath) as? ThemeGameCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(name: secondHeaderData[indexPath.row+1].themeName, image: secondHeaderData[indexPath.row+1].themeImage)
            return cell
        }
        
    }
    
}

extension MainVC: BookmarkCellDelegate {
    func BookmarkCellGiveIndex(_ cell: UICollectionViewCell, didClickedIndex value: Int) {
        
        // 로그인을 안했을 시 -> 로그인을 하라는 창으로 이동
        
        // 로그인을 했을 시
        
        if trendingData[value].saved == 0 {
            // 미저장 -> 저장으로 변경
            
        } else {
            // 저장 -> 미저장으로 변경
            
        }
        
    }
    
    
}
