//
//  SplashVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/06/17.
//

import UIKit
import Lottie

class SplashVC: UIViewController {
    
    var tokenData: TokenData?
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let animationView = AnimationView(name: "boardpediaSplash")
        
        animationView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        animationView.contentMode = .scaleToFill
        view.addSubview(animationView)
        animationView.play(fromProgress: 0,
                           toProgress: 1,
                           loopMode: LottieLoopMode.playOnce,
                           completion: { (finished) in
                            if finished {
                                self.checkDeviceNetworkStatus()
                            } else {
                                // 앱 다시 확인
                            }
                           })
        
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
                        // 토큰 저장
                        
                        let storyboard = UIStoryboard.init(name: "TabBar", bundle: nil)
                        guard let mainTab = storyboard.instantiateViewController(identifier: "TabBarVC") as? TabBarVC else {
                            return
                        }
                        
                        mainTab.modalPresentationStyle = .fullScreen
                        self.present(mainTab, animated: false, completion: nil)
                        // main 화면으로 이동
                        
                    case .failure(let error):
                        print(error)
                        
                    }
                }
                
            } else {
                // 첫 접속 시
                
                UserDefaults.standard.setValue("1234567", forKey: "UserSnsId")
                UserDefaults.standard.setValue("kakao", forKey: "UserProvider")
                // 일단 비회원으로 접속
                
                checkDeviceNetworkStatus()

            }
            
        } else {
            // 네트워크 확인 alert 띄워주기

            self.showNetworkModal()
            
        }
        
    }
    
}
