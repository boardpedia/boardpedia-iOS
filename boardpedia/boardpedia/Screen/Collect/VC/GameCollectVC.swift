//
//  GameCollectVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/27.
//

import UIKit

class GameCollectVC: UIViewController {

    // MARK: Variable Part
    
    var searchResultData: [SearchGameData] = []
    var filterData: [String] = []
    var pageIdx: Int = 0
    var totalGameCount: Int = 0 {
        didSet {
            setResultLabel()
        }
    }
    var isPaging: Bool = false
    
    var playerNum = 0 // 필터 - 인원수
    var level: String = "" // 필터 - 레벨
    var tag: [String] = [] // 필터 - 키워드
    var time: Int = 0 {
        didSet {
            if time == 0 {
                duration = ""
            } else {
                duration = "\(time)분"
            }
        }
    }
    var duration: String = "" // 필터 - 시간
    
    // MARK: IBOutlet
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var filterCollcectionView: UICollectionView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var gameCollectionView: UICollectionView!
    
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            // 동적 사이즈를 주기 위해 estimatedItemSize 를 사용했다. 대략적인 셀의 크기를 먼저 조정한 후에 셀이 나중에 AutoLayout 될 때, 셀의 크기가 변경된다면 그 값이 다시 UICollectionViewFlowLayout에 전달되어 최종 사이즈가 결정되게 된다.
        }
    }
    
    // MARK: IBAction
    
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setResultCollectionView()
        setFilterCollectionView()
        setResultLabel()

        // Do any additional setup after loading the view.
    }

}

// MARK: Extension

extension GameCollectVC {
    
    func setView() {
        self.view.backgroundColor = .boardWhite
        titleLabel.setLabel(text: "보드게임 모아보기", font: .neoSemiBold(ofSize: 18))
    }
    
    // MARK: Result Data Style Function
    
    func setResultCollectionView() {
        
        if NetworkState.isConnected() {
            if let token = UserDefaults.standard.string(forKey: "UserToken") {
              getGameData(jwt: token, pageIdx: pageIdx, playerNum: 0, level: "", tag: [], duration: "")
                
            }
        } else {
            self.showNetworkModal()
        }
        
        let nibName = UINib(nibName: "GameCollectionCell", bundle: nil)
        gameCollectionView.register(nibName, forCellWithReuseIdentifier: "GameCollectionCell")
        
        gameCollectionView.delegate = self
        gameCollectionView.dataSource = self
        gameCollectionView.backgroundColor = .boardGray
        
        initRefresh()
    }
    
    func setFilterCollectionView() {
        
        filterData.append(contentsOf: ["인원 수", "난이도", "키워드", "시간순"])
        filterCollcectionView.delegate = self
        filterCollcectionView.dataSource = self
        filterCollcectionView.backgroundColor = .clear
        
        let layout = filterCollcectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
    }
    
    // MARK: Result Count Label Style Function
    
    func setResultLabel() {
        resultLabel.setLabel(text: "해당 조건의 보드게임이 \(totalGameCount)개 있어요!", color: .boardGray40, font: .neoMedium(ofSize: 15))
        
        if let text = resultLabel.text {
            // 앞부분만 폰트와 컬러를 다르게 설정
            
            let changeString: String = "\(totalGameCount)개"
            let attributedStr = NSMutableAttributedString(string: text)
            
            attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: UIFont.neoSemiBold(ofSize: 15), range: (text as NSString).range(of: changeString))
            attributedStr.addAttribute(.foregroundColor, value: UIColor.boardOrange, range: (text as NSString).range(of: changeString))

            resultLabel.attributedText = attributedStr
        }
    }
    
    func getGameData(jwt: String, pageIdx: Int, playerNum: Int, level: String, tag: [String], duration: String) {
        // 서버 연결 함수 : 게임 데이터 받아오기
        
        APIService.shared.getGameCollection(jwt, pageIdx, playerNum, level, tag, duration) { [self] result in
            switch result {
            
            case .success(let data):
                totalGameCount = data.totalNum
                
                if pageIdx == 0 {
                    searchResultData = data.searchedGame
                    
                    // 스크롤 맨 위로 이동
                    let topOffest = CGPoint(x: 0, y: -(self.gameCollectionView?.contentInset.top ?? 0))
                    self.gameCollectionView?.setContentOffset(topOffest, animated: true)
                    
                } else {
                    searchResultData.insert(contentsOf: data.searchedGame, at: pageIdx*20)
                }
                
                gameCollectionView.reloadData()
                isPaging = false
                
            case .failure(let error):
                print(error)
                
            }
        }
        
    }
    
    // MARK: CollectionView Data Refresh Function
    
    func initRefresh() {
        
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(updateData(refresh:)), for: .valueChanged)
        
        gameCollectionView.addSubview(refresh)
    }
    
    // MARK: Run On CollecionView Refresh Function
    
    @objc func updateData(refresh: UIRefreshControl) {
        
        refresh.endRefreshing()
        
        pageIdx = 0
        
        
        if NetworkState.isConnected() {
            if let token = UserDefaults.standard.string(forKey: "UserToken") {
              getGameData(jwt: token, pageIdx: pageIdx, playerNum: playerNum, level: level, tag: tag, duration: duration)
                
            }
        } else {
            self.showNetworkModal()
        }
        
        
    }
    
    func refreshFilter() {
        // 필터로 인한 초기화
        
        pageIdx = 0
        
        if NetworkState.isConnected() {
            if let token = UserDefaults.standard.string(forKey: "UserToken") {
              getGameData(jwt: token, pageIdx: pageIdx, playerNum: playerNum, level: level, tag: tag, duration: duration)
                
            }
        } else {
            self.showNetworkModal()
        }
        
        
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout

extension GameCollectVC: UICollectionViewDelegateFlowLayout {
    // CollectionView 크기 잡기
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 한 아이템의 크기
        
        if collectionView == gameCollectionView {
            
            let itemWidth = self.view.frame.width - 32
            return CGSize(width: itemWidth, height: 120/343 * itemWidth)
            
        } else {
            return CGSize(width: 30, height: 30)
        }
        
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
        
        if collectionView == gameCollectionView {
            return UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        } else {
            return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
        
    }
    
}

// MARK: UICollectionViewDataSource

extension GameCollectVC: UICollectionViewDataSource {
    // CollectionView 데이터 넣기
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == gameCollectionView {
            return searchResultData.count
        } else {
            return filterData.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == gameCollectionView {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCollectionCell.identifier, for: indexPath) as? GameCollectionCell else {
                return UICollectionViewCell()
            }
            
            if searchResultData[indexPath.row].saved == 1 {
                // 북마크 상태가 true(선택된 상태)라면
                
                cell.bookmarkButton.setImage(UIImage(named: "icStorageSelected"), for: .normal)
                
            } else {
                // 북마크 상태가 false(미선택된 상태)라면
                
                cell.bookmarkButton.setImage(UIImage(named: "icStorageUnselected"), for: .normal)
            }
            
            cell.configure(image: searchResultData[indexPath.row].imageURL, name: searchResultData[indexPath.row].name, info: searchResultData[indexPath.row].intro, star: searchResultData[indexPath.row].star, save: searchResultData[indexPath.row].saveCount)
            
            cell.cellDelegate = self
            cell.cellIndex = indexPath
            
            return cell
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCell.identifier, for: indexPath) as? FilterCell else {
                return UICollectionViewCell()
            }
            
            cell.filterLabel.setLabel(text: filterData[indexPath.row], color: .boardGray50, font: .neoMedium(ofSize: 16))
            cell.contentView.backgroundColor = UIColor(red: 245.0 / 255.0, green: 245.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0)
            cell.contentView.setBorder(borderColor: .none, borderWidth: 1)
            
            if playerNum != 0 && indexPath.row == 0 {
                cell.contentView.backgroundColor = .boardOrange10
                cell.filterLabel.textColor = .boardOrange
                cell.contentView.layer.borderColor = UIColor.boardOrange.cgColor
            }
            
            if level != "" && indexPath.row == 1 {
                
                cell.contentView.backgroundColor = .boardOrange10
                cell.filterLabel.textColor = .boardOrange
                cell.contentView.layer.borderColor = UIColor.boardOrange.cgColor
                
            }
            
            if tag != [] && indexPath.row == 2 {
                cell.contentView.backgroundColor = .boardOrange10
                cell.filterLabel.textColor = .boardOrange
                cell.contentView.layer.borderColor = UIColor.boardOrange.cgColor
            }
            
            if duration != "" && indexPath.row == 3 {
                cell.contentView.backgroundColor = .boardOrange10
                cell.filterLabel.textColor = .boardOrange
                cell.contentView.layer.borderColor = UIColor.boardOrange.cgColor
            }
            
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == gameCollectionView {
            // 게임 CollectionView일 때만 연결
            
            let storyboard = UIStoryboard.init(name: "Game", bundle: nil)
            guard let gameTab = storyboard.instantiateViewController(identifier: "GameVC") as? GameVC else {
                return
            }
            
            self.navigationController?.pushViewController(gameTab, animated: true)
            // 클릭한 게임 상세보기 뷰로 이동
            
            gameTab.gameIndex = searchResultData[indexPath.row].gameIdx
            
        } else if collectionView == filterCollcectionView {
            
            let storyboard = UIStoryboard(name: "Modal", bundle: nil)
            
            if indexPath.row == 0 {
                
                guard let filterVC =
                        storyboard.instantiateViewController(identifier: "CountFilterVC") as? CountFilterVC else {return}
                
                filterVC.modalPresentationStyle = .overFullScreen
                filterVC.modalTransitionStyle = .crossDissolve
                
                filterVC.countFilterAction = {
                    
                    text in
                    
                    if text != self.playerNum {
                        // 검색 인원이 바꼈다면?
                        
                        self.playerNum = text
                        self.filterCollcectionView.reloadData()
                        
                        self.refreshFilter()
                        
                    }
                    
                }
                
                self.present(filterVC, animated: true, completion: nil)
                
                filterVC.count = playerNum
                
            } else if indexPath.row == 1 {
                // 난이도 필터 클릭
                
                guard let filterVC =
                        storyboard.instantiateViewController(identifier: "LevelFilterVC") as? LevelFilterVC else {return}
                
                filterVC.modalPresentationStyle = .overFullScreen
                filterVC.modalTransitionStyle = .crossDissolve
                
                filterVC.levelFilterAction = {
                    
                    text in
                    
                    if text != self.level {
                        // 값이 변경됐다면
                        
                        self.level = text
                        self.filterCollcectionView.reloadData()
                        self.refreshFilter()
                    }
                
                    
                }
                
                if level == "상" {
                    filterVC.myLevel = 0
                } else if level == "중" {
                    filterVC.myLevel = 1
                } else if level == "하" {
                    filterVC.myLevel = 2
                }
                
                self.present(filterVC, animated: true, completion: nil)
                
                
                
            } else if indexPath.row == 2 {
                // 키워드 필터 클릭
                
                guard let filterVC =
                        storyboard.instantiateViewController(identifier: "KeywordFilterVC") as? KeywordFilterVC else {return}
                
                filterVC.modalPresentationStyle = .overFullScreen
                filterVC.modalTransitionStyle = .crossDissolve
                
                filterVC.keywordFilterAction = {
                    
                    text in
                    
                    if text != self.tag {
                        self.tag = text
                        self.filterCollcectionView.reloadData()
                        self.refreshFilter()
                    }
                }
                
                filterVC.keywordData = tag
                
                self.present(filterVC, animated: true, completion: nil)
                
            } else if indexPath.row == 3 {
                
                guard let filterVC =
                        storyboard.instantiateViewController(identifier: "TimeFilterVC") as? TimeFilterVC else {return}
                
                filterVC.modalPresentationStyle = .overFullScreen
                filterVC.modalTransitionStyle = .crossDissolve
                
                filterVC.timeFilterAction = {
                    
                    text in
                    
                    if text != self.time {
                        self.time = text
                        self.filterCollcectionView.reloadData()
                        self.refreshFilter()
                    }
                }
                
                self.present(filterVC, animated: true, completion: nil)
                filterVC.date = time
                
            }
        }
        
        
    }
    
}

extension GameCollectVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        
        if offsetY > (contentHeight - height) && !isPaging {
            isPaging = true
            
            if (totalGameCount - searchResultData.count) > 0 {
                // 아직 가져올 데이터가 남았다면
                
                pageIdx += 1
                if NetworkState.isConnected() {
                    if let token = UserDefaults.standard.string(forKey: "UserToken") {
                        getGameData(jwt: token, pageIdx: pageIdx, playerNum: playerNum, level: level, tag: tag, duration: duration)
                        
                    }
                } else {
                    self.showNetworkModal()
                }
                
                
            }
            
        }
        
    }
}



extension GameCollectVC: BookmarkCellDelegate {
    func BookmarkCellGiveIndex(_ cell: UICollectionViewCell, didClickedIndex value: Int) {
        
        
        if UserDefaults.standard.string(forKey: "UserSnsId") == "1234567" {
            // 비회원이라면 -> 로그인 하라는 창으로 이동
        
            let nextStoryboard = UIStoryboard(name: "Login", bundle: nil)
            guard let popUpVC = nextStoryboard.instantiateViewController(identifier: "LoginPopupVC") as? LoginPopupVC else { return }
            
            self.present(popUpVC, animated: true, completion: nil)
            // 로그인 유도 팝업 띄우기
            
            
        } else {
            // 회원 로그인을 했다면
            if NetworkState.isConnected() {
                if let token = UserDefaults.standard.string(forKey: "UserToken") {
                    // 토큰 존재 시
                    
                    if searchResultData[value].saved == 0 {
                        // 미저장 -> 저장으로 변경
                        
                        APIService.shared.saveGame(token, searchResultData[value].gameIdx) { [self] result in
                            switch result {
                            
                            case .success(_):
                                
                                searchResultData[value].saved = 1
                                gameCollectionView.reloadData()
                                
                            case .failure(let error):
                                print(error)
                                
                            }
                            
                        }
                    } else {
                        // 저장 -> 미저장으로 변경
                        
                        APIService.shared.saveCancleGame(token, searchResultData[value].gameIdx) { [self] result in
                            switch result {
                            
                            case .success(_):
                                
                                searchResultData[value].saved = 0
                                gameCollectionView.reloadData()
                                
                            case .failure(let error):
                                print(error)
                                
                            }
                            
                        }
                        
                    }
                    
                }
            } else {
                self.showNetworkModal()
            }
            
            
        }
    }
}
