//
//  MypageVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/11.
//

import UIKit
import XLPagerTabStrip

class MypageVC: ButtonBarPagerTabStripViewController {
    
    // MARK: Variable Part
    
    // MARK: IBOutlet
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nickLabel: UILabel!
    @IBOutlet weak var levelButton: UIButton!
    
    // MARK: IBAction
    
    //    @IBAction func saveListButtonDidTap(_ sender: Any) {
    //
    //        saveListButton.setButton(text: "저장 목록", font: .neoSemiBold(ofSize: 16))
    //        reviewListButton.setButton(text: "후기 목록", color: .boardGray50, font: .neoMedium(ofSize: 16))
    //
    //    }
    //
    //    @IBAction func reviewListButtonDidTap(_ sender: Any) {
    //
    //        reviewListButton.setButton(text: "후기 목록", font: .neoSemiBold(ofSize: 16))
    //        saveListButton.setButton(text: "저장 목록", color: .boardGray50, font: .neoMedium(ofSize: 16))
    //    }
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
//        let saveList = UIStoryboard.init(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchResultVC") as! SearchResultVC
//        saveList.tabName = "저장 목록"
////        saveList.nibName
//
//
////        let reviewList = UIStoryboard(name: "Calendar", bundle: nil).instantiateViewController(withIdentifier: "CalendarVC") as! MypageVC
//        reviewList.tabName = "후기 목록"
        
        return []
    }
    
}

// MARK: Extension

extension MypageVC {
    
    func setView() {
        //        saveListButtonDidTap(self)
    }
    
    
}
