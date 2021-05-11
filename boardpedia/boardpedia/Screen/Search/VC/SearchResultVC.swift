//
//  SearchResultVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/11.
//

import UIKit

class SearchResultVC: UIViewController {
    
    // MARK: Variable Part
    
    // MARK: IBOutlet
    
    @IBOutlet var filterButton: [UIButton]!
    
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
        
        // Do any additional setup after loading the view.
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
}
