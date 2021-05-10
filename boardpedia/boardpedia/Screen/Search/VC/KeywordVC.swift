//
//  KeywordVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/11.
//

import UIKit

class KeywordVC: UIViewController {

    // MARK: Variable Part
    
    @IBOutlet weak var recentKeywordView: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var recentKeywordCollectionView: UICollectionView!
    
    // MARK: IBOutlet
    
    // MARK: IBAction
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
}

// MARK: Extension

extension KeywordVC {
    
    // MARK: View Style Function
    
    func setView() {
        infoLabel.setLabel(text: "최근 검색어", font: .neoBold(ofSize: 16))
    }
    
    // MARK: No Recent Keyword Style Function
    
    func setNoKeyword() {
        // 최근 검색어가 없는 상황
        
        let noKeywordLabel = UILabel()
        self.view.addSubview(noKeywordLabel)
        noKeywordLabel.translatesAutoresizingMaskIntoConstraints = false
        noKeywordLabel.topAnchor.constraint(equalTo: self.infoLabel.bottomAnchor, constant: 16).isActive = true
        noKeywordLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 17).isActive = true
        
        noKeywordLabel.setLabel(text: "검색어가 아직 없어요!", color: .boardGray30, font: .neoMedium(ofSize: 17))
    }
    
}
