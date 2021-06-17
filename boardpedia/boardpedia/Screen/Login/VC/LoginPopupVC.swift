//
//  LoginPopupVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/06/05.
//

import UIKit

class LoginPopupVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 뒷 배경 클릭 시 Event
        
        super.touchesBegan(touches, with: event)
        if let touch = touches.first , touch.view == self.view {
            
            self.dismiss(animated: true, completion: nil)
            
            
        }
    }

}
