//
//  SearchResultVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/11.
//

import UIKit

class SearchResultVC: UIViewController {
    
    // MARK: Variable Part
    
    var number: Int = 0 {
        // number가 바뀔 때 마다 실행
        didSet {
            setResultLabel()
        }
    }
    
    // MARK: IBOutlet
    
    @IBOutlet var filterButton: [UIButton]!
    @IBOutlet weak var resultLabel: UILabel!
    
    // MARK: IBAction
    
    @IBAction func filterButtonDidTap(_ sender: Any) {
        
        for i in Range(0...3) {
            if filterButton[i].isTouchInside {
                // 터치된 특정 인덱스 찾기
//                number += 1
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
        resultLabel.setLabel(text: "전체 \(number)개의 검색 결과가 있어요!", color: .boardGray40, font: .neoMedium(ofSize: 15))
        
        if let text = resultLabel.text {
            // 앞부분만 폰트와 컬러를 다르게 설정
            
            let changeString: String = "\(number)개"
            let attributedStr = NSMutableAttributedString(string: text)
            
            attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: UIFont.neoSemiBold(ofSize: 15), range: (text as NSString).range(of: changeString))
            attributedStr.addAttribute(.foregroundColor, value: UIColor.boardOrange, range: (text as NSString).range(of: changeString))

            resultLabel.attributedText = attributedStr
        }
    }
}
