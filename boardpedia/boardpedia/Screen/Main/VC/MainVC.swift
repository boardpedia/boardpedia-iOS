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
    var todayThemeData: [ThemeData] = []
    var firstTag: [String] = []
    
    // MARK: IBOutlet
    
    @IBOutlet weak var seachButton: UIButton!
    @IBOutlet weak var firstHeaderLabel: UILabel!
    @IBOutlet weak var trandingGameCollectionView: UICollectionView!
    
    @IBOutlet weak var secondHeaderLabel: UILabel!
    @IBOutlet weak var explainLabel: UILabel!
    
    @IBOutlet weak var bestThemeImageView: UIImageView!
    @IBOutlet weak var bestThemeButton: UIButton!
    @IBOutlet weak var bestThemeNameLabel: UILabel!
    @IBOutlet weak var themeGameCollectionView: UICollectionView!
    
    @IBOutlet weak var instagramButton: UIButton!
    @IBOutlet weak var stackFirstLabel: UILabel!
    @IBOutlet weak var stackSecondLabel: UILabel!
    
    @IBOutlet weak var keywordCollectionView: UICollectionView!
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    // MARK: IBAction
    
    
    @IBAction func searchButtonDidTap(_ sender: Any) {
        
        let storyboard = UIStoryboard.init(name: "Search", bundle: nil)
        guard let searchTab = storyboard.instantiateViewController(identifier: "SearchVC") as? SearchVC else {
            return
        }
        self.navigationController?.pushViewController(searchTab, animated: true)
        searchTab.topKeyword = trendingData
        
    }
    
    
    @IBAction func bestThemeButtonDidTap(_ sender: Any) {
        
        guard let themeVC = self.storyboard?.instantiateViewController(identifier: "ThemeVC") as? ThemeVC else {
            return
        }
        
        self.navigationController?.pushViewController(themeVC, animated: true)
        // 테마 뷰로 이동
        themeVC.themeIdx = todayThemeData[0].themeIdx
        // 클릭한 테마 themeIdx 전달
    }
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setCollectionView()
        
        if let token = UserDefaults.standard.string(forKey: "UserToken") {
            trendingGameData(jwt: token)
            todayThemeData(jwt: token)
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let token = UserDefaults.standard.string(forKey: "UserToken") {
            trendingGameData(jwt: token)
        }
        
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
            
            attributedStr.addAttribute(.foregroundColor, value: UIColor.boardOrange, range: (text as NSString).range(of: "Now!"))
            
            firstHeaderLabel.attributedText = attributedStr
        }
        
        secondHeaderLabel.setLabel(text: "오늘의 추천 테마", font: .neoSemiBold(ofSize: 20))
        explainLabel.setLabel(text: "보드게임 진심러들이 고른 진짜 중 진짜!", color: .boardGray50, font: .neoMedium(ofSize: 15))
        
        bestThemeButton.setRounded(radius: 6)
        bestThemeImageView.setRounded(radius: 6)
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
        
        themeGameCollectionView.delegate = self
        themeGameCollectionView.dataSource = self
        
        let layout = keywordCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .vertical
        keywordCollectionView.delegate = self
        keywordCollectionView.dataSource = self
        keywordCollectionView.backgroundColor = .none
        
        let customLayout = LeftAlignFlowLayout()
        keywordCollectionView.collectionViewLayout = customLayout
        customLayout.estimatedItemSize = CGSize(width: 41, height: 41)
        
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
    
    func todayThemeData(jwt: String) {
        
        APIService.shared.todayTheme(jwt) { [self] result in
            switch result {
            
            case .success(let data):
                
                todayThemeData = data
                themeGameCollectionView.reloadData()
                
                firstTag = todayThemeData[0].tag
                keywordCollectionView.reloadData()
                
                bestThemeNameLabel.setLabel(text: todayThemeData[0].name, color: .boardWhite, font: .neoBold(ofSize: 24))
                bestThemeImageView.setImage(from: todayThemeData[0].imageURL)
                
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
        } else if collectionView == keywordCollectionView {
            return CGSize(width: 36, height: 36)
        } else {
            let itemWidth = self.themeGameCollectionView.frame.width / 2 - 7.5
            return CGSize(width: itemWidth, height: itemWidth)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // 아이템간의 간격
        
        if collectionView == trandingGameCollectionView {
            return 10
        } else if collectionView == keywordCollectionView {
            return 0
        } else {
            return 15
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView == keywordCollectionView {
            return 10
        } else {
            return 0
        }
        
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
        } else if collectionView == keywordCollectionView {
            return firstTag.count
        } else {
            return todayThemeData.count - 1
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
            
        } else if collectionView == keywordCollectionView {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeKeywordCell.identifier, for: indexPath) as? ThemeKeywordCell else {
                return UICollectionViewCell()
            }
            cell.configure(title: firstTag[indexPath.row])
        
            return cell
        }
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeGameCell.identifier, for: indexPath) as? ThemeGameCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(name: todayThemeData[indexPath.row+1].name, image: todayThemeData[indexPath.row+1].imageURL, keyword: todayThemeData[indexPath.row+1].tag)
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // collectionView Cell 클릭 시
        
        if collectionView == themeGameCollectionView {
            // 테마 콜렉션 뷰라면?
            
            guard let themeVC = self.storyboard?.instantiateViewController(identifier: "ThemeVC") as? ThemeVC else {
                return
            }
            
            self.navigationController?.pushViewController(themeVC, animated: true)
            // 테마 뷰로 이동
            themeVC.themeIdx = todayThemeData[indexPath.row+1].themeIdx
            // 클릭한 테마 themeIdx 전달
            
        } else if collectionView == trandingGameCollectionView {
            // 트렌딩 게임을 선택했다면?
            
            let storyboard = UIStoryboard.init(name: "Game", bundle: nil)
            guard let gameTab = storyboard.instantiateViewController(identifier: "GameVC") as? GameVC else {
                return
            }
            
            self.navigationController?.pushViewController(gameTab, animated: true)
            // 클릭한 게임 상세보기 뷰로 이동
            
        }
        
    }
    
}

extension MainVC: BookmarkCellDelegate {
    func BookmarkCellGiveIndex(_ cell: UICollectionViewCell, didClickedIndex value: Int) {
        
        
        if UserDefaults.standard.string(forKey: "UserSnsId") == "1234567" {
            // 비회원이라면 -> 로그인 하라는 창으로 이동
        
            let nextStoryboard = UIStoryboard(name: "Login", bundle: nil)
            guard let popUpVC = nextStoryboard.instantiateViewController(identifier: "LoginPopupVC") as? LoginPopupVC else { return }
            
            self.present(popUpVC, animated: true, completion: nil)
            // 로그인 유도 팝업 띄우기
            
            
        } else {
            // 회원 로그인을 했다면
            
            if let token = UserDefaults.standard.string(forKey: "UserToken") {
                // 토큰 존재 시
                
                if trendingData[value].saved == 0 {
                    // 미저장 -> 저장으로 변경
                    
                    APIService.shared.saveGame(token, trendingData[value].gameIdx) { [self] result in
                        switch result {
                        
                        case .success(_):
                            
                            trendingGameData(jwt: token)
                            
                        case .failure(let error):
                            print(error)
                            
                        }
                        
                    }
                } else {
                    // 저장 -> 미저장으로 변경
                    
                    APIService.shared.saveCancleGame(token, trendingData[value].gameIdx) { [self] result in
                        switch result {
                        
                        case .success(_):
                            
                            trendingGameData(jwt: token)
                            
                        case .failure(let error):
                            print(error)
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
    }
}
