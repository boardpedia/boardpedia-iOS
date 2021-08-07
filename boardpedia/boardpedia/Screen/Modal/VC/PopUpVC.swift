//
//  PopUpVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/08/07.
//

import UIKit

class PopUpVC: UIViewController {

    @IBOutlet weak var popupView: UIView!
    var popButtonAction : (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.setRounded(radius: 6)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
          // 1초 후 실행될 부분
            
            self.dismiss(animated: true) {
                
                guard let pagePluginButtonAction = self.popButtonAction else {
                    return
                }
                
                pagePluginButtonAction()
                
            }
        }
        // Do any additional setup after loading the view.
    }
    

}
