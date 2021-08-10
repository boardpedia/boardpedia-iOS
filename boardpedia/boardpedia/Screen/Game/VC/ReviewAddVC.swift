//
//  ReviewAddVC.swift
//  boardpedia
//
//  Created by Hailey on 2021/08/10.
//

import UIKit
import Cosmos

class ReviewAddVC: UIViewController {

    
    @IBOutlet weak var starView: CosmosView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStar()
        
    }


}

extension ReviewAddVC {
    
    func setStar() {
        // 별점 관리
        
        starView.rating = 0
        starView.settings.starSize = 40
        starView.settings.starMargin = 12
        starView.didFinishTouchingCosmos  = { rating in
            print(self.starView.rating)
        }
        
    }
}
