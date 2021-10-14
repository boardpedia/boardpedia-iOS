//
//  NetworkErrorVC.swift
//  boardpedia
//
//  Created by Hailey on 2021/08/11.
//

import UIKit

class NetworkErrorVC: UIViewController {

    @IBOutlet weak var popView: UIView!
    
    @IBOutlet weak var retryButton: UIButton!
    @IBAction func retryButtonDidTap(_ sender: Any) {
        // 재시도
        
        exit(0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popView.setRounded(radius: 10)
        retryButton.setRounded(radius: 8)
        // Do any additional setup after loading the view.
    }
    
}
