//
//  SplashVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/06/17.
//

import UIKit

class SplashVC: UIViewController {
    
    var tokenData: TokenData?
    
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
            
            if let id = UserDefaults.standard.string(forKey: "UserSnsId"),
               let provider = UserDefaults.standard.string(forKey: "UserProvider") {
                // 이전 접속 기록 존재 시
                
                APIService.shared.login(id, provider) { [self] result in
                    switch result {
                    
                    case .success(let data):
                        
                        tokenData = data
                        UserDefaults.standard.setValue(tokenData?.accessToken, forKey: "UserToken")
                        
                    case .failure(let error):
                        print(error)
                        
                    }
                }
                
            } else {
                // 첫 접속 시
                
                UserDefaults.standard.setValue("1234567", forKey: "UserSnsId")
                UserDefaults.standard.setValue("kakao", forKey: "UserProvider")
                // 비회원으로 접속
                
                checkDeviceNetworkStatus()

            }
            
        } else {
            // 네트워크 확인 alert 띄워주기
            
        }
        
    }
    
}
