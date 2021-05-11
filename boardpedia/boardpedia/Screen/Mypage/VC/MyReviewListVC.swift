//
//  MyReviewListVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/12.
//

import UIKit
import XLPagerTabStrip

class MyReviewListVC: UIViewController, IndicatorInfoProvider {

    // MARK: Variable Part
    
    var tabName: String = ""
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {

        super.didReceiveMemoryWarning()

      }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {

        return IndicatorInfo(title: "\(tabName)")

      }

}
