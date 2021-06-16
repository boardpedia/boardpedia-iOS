//
//  SplashVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/06/17.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        checkDeviceNetworkStatus()

        // Do any additional setup after loading the view.
    }


}

extension SplashVC {
    
    func checkDeviceNetworkStatus() {
        
        if NetworkState.isConnected() {
            // 네트워크 연결 시
            
        }
        
    }
    
}
