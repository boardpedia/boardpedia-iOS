//
//  TabBarVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/06/23.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
        
        self.viewControllers?.forEach {
            let _ = $0.view
            $0.viewWillAppear(true)
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UITabBar.appearance().tintColor = .boardOrange
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().backgroundColor = .boardWhite
        UITabBar.appearance().itemPositioning = .automatic
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.neoSemiBold(ofSize: 11)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.neoBold(ofSize: 11)], for: .selected)
    }

}

extension TabBarVC {
    
    func setTabBar() {
        //탭바 설정
        
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        guard let mainVC = mainStoryboard.instantiateViewController(identifier: "MainNaviVC") as? MainNaviVC else {
            return
        }
        
        let collectStoryboard = UIStoryboard.init(name: "GameCollect", bundle: nil)
        guard let collectVC = collectStoryboard.instantiateViewController(identifier: "GameCollectionNaviVC") as? GameCollectionNaviVC else {
            return
        }
        
        let mypageStoryboard = UIStoryboard.init(name: "Mypage", bundle: nil)
        guard let mypageVC = mypageStoryboard.instantiateViewController(identifier: "MypageNaviVC") as? MypageNaviVC else {
            return
        }
        
        
        
        mainVC.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        mainVC.tabBarItem.image = UIImage(named: "icHomeUnselected")
        mainVC.tabBarItem.selectedImage = UIImage(named: "icHomeSelected")
//        mainVC.title.color
        mainVC.title = "홈"
        
        collectVC.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectVC.tabBarItem.image = UIImage(named: "icGameUnselected")
        collectVC.tabBarItem.selectedImage = UIImage(named: "icGameSelected")
        collectVC.title = "모아보기"
        
        mypageVC.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        mypageVC.tabBarItem.image = UIImage(named: "icMypageUnselected")
        mypageVC.tabBarItem.selectedImage = UIImage(named: "icMypageSelected")
        mypageVC.title = "마이피디아"
        
        
        setViewControllers([mainVC, collectVC, mypageVC], animated: true)
        
    }
    
}
