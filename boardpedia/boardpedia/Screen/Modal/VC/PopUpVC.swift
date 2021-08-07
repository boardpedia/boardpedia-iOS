//
//  PopUpVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/08/07.
//

import UIKit

class PopUpVC: UIViewController {

    @IBOutlet weak var popupView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.setRounded(radius: 6)
        // Do any additional setup after loading the view.
    }
    

}
