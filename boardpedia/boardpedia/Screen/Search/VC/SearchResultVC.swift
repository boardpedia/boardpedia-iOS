//
//  SearchResultVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/11.
//

import UIKit

class SearchResultVC: UIViewController {
    
    // MARK: Variable Part
    
    var searchResultData: [SearchResultData] = [] {
        didSet {
            // 데이터 값이 바뀔 때 마다 라벨 변경
            
            setResultLabel()
        }
    }
    
    // MARK: IBOutlet
    
    @IBOutlet var filterButton: [UIButton]!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var searchResultCollectionView: UICollectionView!
    
    // MARK: IBAction
    
    @IBAction func filterButtonDidTap(_ sender: Any) {
        
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
            
        }
        
    }
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButton()
        setResultLabel()
        setResultCollectionView()
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
            button.setRounded(radius: button.frame.width/5)
            button.tintColor = .clear
        }
        
    }
    
    // MARK: Result Count Label Style Function
    
    func setResultLabel() {
        resultLabel.setLabel(text: "전체 \(searchResultData.count)개의 검색 결과가 있어요!", color: .boardGray40, font: .neoMedium(ofSize: 15))
        
        if let text = resultLabel.text {
            // 앞부분만 폰트와 컬러를 다르게 설정
            
            let changeString: String = "\(searchResultData.count)개"
            let attributedStr = NSMutableAttributedString(string: text)
            
            attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: UIFont.neoSemiBold(ofSize: 15), range: (text as NSString).range(of: changeString))
            attributedStr.addAttribute(.foregroundColor, value: UIColor.boardOrange, range: (text as NSString).range(of: changeString))

            resultLabel.attributedText = attributedStr
        }
    }
    
    // MARK: Result Data Style Function
    
    func setResultCollectionView() {
        
        // Test Data (서버 연결 전)
        let themeItem1 = SearchResultData(gameImage: "testImage", gameName: "할리갈리 디럭스", gameInfo: "벨과 함께 즐기는 스릴감", saveNumber: 100, startNumber: 4.5, bookMark: false)
        
        searchResultData.append(contentsOf: [themeItem1,themeItem1,themeItem1,themeItem1,themeItem1,themeItem1,themeItem1])
        
        
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
        searchResultCollectionView.backgroundColor = .boardGray
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
        
        return searchResultData.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCell.identifier, for: indexPath) as? SearchResultCell else {
            return UICollectionViewCell()
        }
        
        cell.cellDelegate = self
        cell.cellIndex = indexPath
        // Cell의 indexPath 저장
        
        if searchResultData[indexPath.row].bookMark {
            // 북마크 상태가 true(선택된 상태)라면
            
            cell.bookmarkButton.setImage(UIImage(named: "icStorageSelected"), for: .normal)
        } else {
            // 북마크 상태가 false(미선택된 상태)라면
            
            cell.bookmarkButton.setImage(UIImage(named: "icStorageUnselected"), for: .normal)
        }
        
        cell.configure(image: searchResultData[indexPath.row].gameImage, name: searchResultData[indexPath.row].gameName, info: searchResultData[indexPath.row].gameInfo, star: searchResultData[indexPath.row].startNumber, save: searchResultData[indexPath.row].saveNumber)
        
        return cell
        
    }
    
}


extension SearchResultVC: SearchResultCellDelegate {
    func SearchResultCellGiveIndex(_ cell: SearchResultCell, didClickedIndex value: Int) {
        
        searchResultData[value].bookMark = !searchResultData[value].bookMark
        // 북마크 상태 반대로 전환 (선택 <--> 미선택)
        
        self.searchResultCollectionView.reloadData()
        // 새로고침
    }
    
    
}
