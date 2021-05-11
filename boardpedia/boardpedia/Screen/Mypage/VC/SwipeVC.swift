//
//  SwipeVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/12.
//

import UIKit
import XLPagerTabStrip

class SwipeVC: ButtonBarPagerTabStripViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabbarStyle()
        // Do any additional setup after loading the view.
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let saveList = self.storyboard?.instantiateViewController(withIdentifier: "MySaveListVC") as! MySaveListVC
        saveList.tabName = "저장 목록"
        
        
        let reviewList = self.storyboard?.instantiateViewController(withIdentifier: "MyReviewListVC") as! MyReviewListVC
        reviewList.tabName = "후기 목록"
        
        return [saveList, reviewList]
    }
    
    override func didReceiveMemoryWarning() {

        super.didReceiveMemoryWarning()

      }
    
    func setTabbarStyle() {

        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .boardGray50
            newCell?.label.textColor = .boardBlack
            newCell?.label.font = .neoSemiBold(ofSize: 16)
            oldCell?.label.font = .neoMedium(ofSize: 16)
        }
    }
}
