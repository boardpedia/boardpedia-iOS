//
//  LogoutPopUpVC.swift
//  boardpedia
//
//  Created by Hailey on 2021/09/02.
//

import UIKit

class LogoutPopUpVC: UIViewController {
    
    
    var logoutAction : ((String) -> Void)?
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var logoutButton: UIButton!
    
    
    @IBAction func closeButtonDidTap(_ sender: Any) {
        self.dismiss(animated: true)
        
    }
    
    @IBAction func logoutButtonDidTap(_ sender: Any) {
        
        self.dismiss(animated: true) {
            // 비회원 전용 아이디로 변경
            
            UserDefaults.standard.removeObject(forKey: "UserToken") // 토큰 삭제
            UserDefaults.standard.setValue("1234567", forKey: "UserSnsId")
            UserDefaults.standard.setValue("kakao", forKey: "UserProvider")
            
            guard let logoutAction = self.logoutAction else {
                return
            }
            
            logoutAction("로그아웃 완료 🥕")
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
