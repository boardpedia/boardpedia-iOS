//
//  LogoutPopUpVC.swift
//  boardpedia
//
//  Created by Hailey on 2021/09/02.
//

import UIKit

class LogoutPopUpVC: UIViewController {
    
    
    var logoutAction : ((String) -> Void)?
    var tokenData: TokenData?
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var logoutButton: UIButton!
    
    
    @IBAction func closeButtonDidTap(_ sender: Any) {
        self.dismiss(animated: true)
        
    }
    
    @IBAction func logoutButtonDidTap(_ sender: Any) {
        
        UserDefaults.standard.setValue("1234567", forKey: "UserSnsId")
        UserDefaults.standard.setValue("kakao", forKey: "UserProvider")
        
        if NetworkState.isConnected() {
            // 네트워크 연결 시
            
            if let id = UserDefaults.standard.string(forKey: "UserSnsId"),
               let provider = UserDefaults.standard.string(forKey: "UserProvider") {
                
                APIService.shared.login(id, provider) { [self] result in
                    switch result {
                    
                    case .success(let data):
                        
                        tokenData = data
                        UserDefaults.standard.setValue(tokenData?.accessToken, forKey: "UserToken")
                        // 토큰 저장
                    
                        self.dismiss(animated: true) {
                            
                            guard let logoutAction = self.logoutAction else {
                                return
                            }
                            
                            logoutAction("로그아웃 완료 🥕")
                        }
                        
                        
                    case .failure(let error):
                        print(error)
                        
                    }
                }
                
            }
            
            
        } else {
            // 네트워크 확인 alert 띄워주기

            self.showNetworkModal()
            
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 뷰 클릭 시 뷰 내리기
        
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.setRounded(radius: 10)
        logoutButton.setRounded(radius: 8)
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
