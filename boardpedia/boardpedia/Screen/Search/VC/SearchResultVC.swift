//
//  SearchResultVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/11.
//

import UIKit

class SearchResultVC: UIViewController {
    
    // MARK: Variable Part
    
    var searchResult: [SearchGameData] = [] {
        didSet {
            // 데이터 값이 바뀔 때 마다 라벨 변경
            
            setResultLabel()
        }
    }
    
    var copySearchResult: [SearchGameData] = []
    // 검색결과 필터로 인한 초기화를 위해 복사본 생성
    
    var searchWord: String?
    
    // MARK: IBOutlet
    
    @IBOutlet var filterButton: [UIButton]!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var searchResultCollectionView: UICollectionView!
    
    // MARK: IBAction
    
    @IBAction func filterButtonDidTap(_ sender: Any) {
        
        searchResult = copySearchResult
        // 정렬 초기화
        
        for i in Range(0...3) {
            
            if filterButton[i].isTouchInside {
                // 터치된 특정 인덱스 찾기
                
                filterButton[i].isSelected = !filterButton[i].isSelected
                // 활성화 <--> 비활성화
                
                if filterButton[i].isSelected {
                    // 선택된 상태라면
                    
                    filterButton[i].backgroundColor = .boardOrange
                    filterButton[i].setTitleColor(.white, for: .normal)
                    
                } else {
                    // 선택 취소된 상태라면
                    
                    filterButton[i].backgroundColor = .clear
                    filterButton[i].setTitleColor(.boardOrange, for: .normal)
                    
                }
            }
            
            if filterButton[i].isSelected {
                // 선택된 필터가 있다면
                
                if i == 1 {
                    searchResult = searchResult.sorted(by: {$0.name < $1.name})
                } else if i == 2 {
                    searchResult = searchResult.sorted(by: {$0.star > $1.star})
                } else if i == 3 {
                    searchResult = searchResult.sorted(by: {$0.saveCount > $1.saveCount})
                }
            }
            
            searchResultCollectionView.reloadData()
            

            
        }
        
    }
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButton()
        setResultLabel()
        setResultCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let searchWord = searchWord,
           let token = UserDefaults.standard.string(forKey: "UserToken") {
            self.searchNetwork(jwt: token, inputWord: searchWord)
        }
    }
    
}

// MARK: Extension

extension SearchResultVC {
    
    // MARK: Button Style Function
    
    func setButton() {
        
        for button in filterButton {
            
            button.titleLabel?.font = .neoMedium(ofSize: 16)
            button.setTitleColor(.boardOrange, for: .normal)
            button.setBorder(borderColor: .boardOrange, borderWidth: 1)
            button.setRounded(radius: button.frame.width/5.5)
            button.tintColor = .clear
        }
        
    }
    
    // MARK: Result Count Label Style Function
    
    func setResultLabel() {
        resultLabel.setLabel(text: "전체 \(searchResult.count)개의 검색 결과가 있어요!", color: .boardGray40, font: .neoMedium(ofSize: 15))
        
        if let text = resultLabel.text {
            // 앞부분만 폰트와 컬러를 다르게 설정
            
            let changeString: String = "\(searchResult.count)개"
            let attributedStr = NSMutableAttributedString(string: text)
            
            attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: UIFont.neoSemiBold(ofSize: 15), range: (text as NSString).range(of: changeString))
            attributedStr.addAttribute(.foregroundColor, value: UIColor.boardOrange, range: (text as NSString).range(of: changeString))
            
            resultLabel.attributedText = attributedStr
        }
    }
    
    // MARK: Result Data Style Function
    
    func setResultCollectionView() {
        
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
        searchResultCollectionView.backgroundColor = .boardGray
    }
    
    func setNoSearchData() {
        // 검색 결과가 없을 때
        
        self.view.backgroundColor = .boardGray
        
        let infoLabel = UILabel()
        self.view.addSubview(infoLabel)
        
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        infoLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        infoLabel.centerYAnchor.constraint(equalTo: self.searchResultCollectionView.centerYAnchor).isActive = true
        
        infoLabel.setLabel(text: "찾고있는 보드게임이 없나요?", font: .neoMedium(ofSize: 16))
        
        
        let brandImage = UIImageView()
        self.view.addSubview(brandImage)
        
        brandImage.translatesAutoresizingMaskIntoConstraints = false
        
        brandImage.widthAnchor.constraint(equalToConstant: 104/375 * self.view.frame.width).isActive = true
        brandImage.heightAnchor.constraint(equalToConstant: 104/375 * self.view.frame.width).isActive = true
        brandImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        brandImage.bottomAnchor.constraint(equalTo: infoLabel.topAnchor, constant: -25).isActive = true
        
        brandImage.image = UIImage(named: "brandNoDataChacter")
        
        let addButton = UIButton()
        self.view.addSubview(addButton)
        
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        addButton.widthAnchor.constraint(equalToConstant: 164/375 * self.view.frame.width).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 40/375 * self.view.frame.width).isActive = true
        addButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        addButton.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 30).isActive = true
        
        addButton.setButton(text: "내가 직접 추가해보기", color: .boardOrange, font: .neoSemiBold(ofSize: 16), backgroundColor: .boardWhite)
        addButton.setBorder(borderColor: .boardOrange, borderWidth: 1)
        addButton.setRounded(radius: 6)
        addButton.addTarget(self, action: #selector(addGameView), for: .touchUpInside)
        
        for i in Range(0...3) {
            filterButton[i].isEnabled = false
        }
        
        
    }
    
    @objc func addGameView() {
        // 보드게임 추가하기 뷰로 연결
        
        let storyboard = UIStoryboard.init(name: "Game", bundle: nil)
        
        guard let gameAddVC = storyboard.instantiateViewController(identifier: "GameAddVC") as? GameAddVC else {
            return
        }
        gameAddVC.modalPresentationStyle = .fullScreen
        self.present(gameAddVC, animated: true)
        
    }
    
    func searchNetwork(jwt: String, inputWord: String) {
        
        if NetworkState.isConnected() {
            // 네트워크 연결 시
            
            APIService.shared.searchResult(jwt, inputWord) { [self] result in
                switch result {
                
                case .success(let data):
                    searchResult = data
                    copySearchResult = data
                    
                    if searchResult.count == 0 {
                        // 해당 검색어의 검색 결과가 없을 때
                        
                        setNoSearchData()
                        
                    } else {
                        // 해당 검색어의 검색 결과가 있을 때
                        
                        searchResultCollectionView.reloadData()
                    }
                    
                    
                case .failure(let error):
                    print(error)
                    
                }
                
            }
        } else {
            // 네트워크 제연결 팝업
            
            
        }
    }
}


// MARK: UICollectionViewDelegateFlowLayout

extension SearchResultVC: UICollectionViewDelegateFlowLayout {
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
        
        return UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        
    }
    
}

// MARK: UICollectionViewDataSource

extension SearchResultVC: UICollectionViewDataSource {
    // CollectionView 데이터 넣기
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return searchResult.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCell.identifier, for: indexPath) as? SearchResultCell else {
            return UICollectionViewCell()
        }
        
        cell.cellDelegate = self
        cell.cellIndex = indexPath
        // Cell의 indexPath 저장
        
        if searchResult[indexPath.row].saved == 1 {
            // 북마크 상태가 true(선택된 상태)라면
            
            cell.bookmarkButton.setImage(UIImage(named: "icStorageSelected"), for: .normal)
            
        } else {
            // 북마크 상태가 false(미선택된 상태)라면
            
            cell.bookmarkButton.setImage(UIImage(named: "icStorageUnselected"), for: .normal)
        }
        
        cell.configure(image: searchResult[indexPath.row].imageURL, name: searchResult[indexPath.row].name, info: searchResult[indexPath.row].intro, star: searchResult[indexPath.row].star, save: searchResult[indexPath.row].saveCount)
        
        return cell
        
    }
    
}


extension SearchResultVC: BookmarkCellDelegate {
    
    func BookmarkCellGiveIndex(_ cell: UICollectionViewCell, didClickedIndex value: Int) {
        
        if UserDefaults.standard.string(forKey: "UserSnsId") == "1234567" {
            // 비회원이라면 -> 로그인 하라는 창으로 이동
            
            let nextStoryboard = UIStoryboard(name: "Login", bundle: nil)
            guard let popUpVC = nextStoryboard.instantiateViewController(identifier: "LoginPopupVC") as? LoginPopupVC else { return }
            
            self.present(popUpVC, animated: true, completion: nil)
            // 로그인 유도 팝업 띄우기
            
            
        } else {
            
            if let token = UserDefaults.standard.string(forKey: "UserToken"),
               let searchWord = searchWord {
                // 토큰 존재 시
                if searchResult[value].saved == 0 {
                    // 미저장 -> 저장으로 변경
                    
                    APIService.shared.saveGame(token, searchResult[value].gameIdx) { [self] result in
                        switch result {
                        
                        case .success(_):
                            
                            self.searchNetwork(jwt: token, inputWord: searchWord)
                            
                        case .failure(let error):
                            print(error)
                            
                        }
                        
                    }
                    
                } else {
                    // 저장 -> 미저장으로 변경
                    
                    APIService.shared.saveCancleGame(token, searchResult[value].gameIdx) { [self] result in
                        switch result {
                        
                        case .success(_):
                            
                            self.searchNetwork(jwt: token, inputWord: searchWord)
                            
                        case .failure(let error):
                            print(error)
                            
                        }
                        
                    }
                }
                
                
            }
        }
    }
    
    
}
