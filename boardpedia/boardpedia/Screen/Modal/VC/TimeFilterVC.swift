//
//  TimeFilterVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/08/07.
//

import UIKit

class TimeFilterVC: UIViewController {
    
    var date: Int = 10 {
        didSet {
            timeLabel.text = "\(date)분"
        }
    }

    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    @IBAction func minusButtonDidTap(_ sender: Any) {
        
    }
    
    @IBAction func plusButtonDidTap(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
