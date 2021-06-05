//
//  NickVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/06/05.
//

import UIKit

class NickVC: UIViewController {

    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var nickTextField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        // Do any additional setup after loading the view.
    }
    

}

extension NickVC {
    
    func setView() {
        
        levelLabel.setLabel(text: "보드초보자", color: .boardOrange, font: .neoMedium(ofSize: 15))
        levelLabel.setRounded(radius: 12)
        levelLabel.setBorder(borderColor: .boardOrange, borderWidth: 1)
        levelLabel.backgroundColor = UIColor(red: 1.0, green: 119.0 / 255.0, blue: 72.0 / 255.0, alpha: 0.1)
        
        nickTextField.backgroundColor = .backGray
        nickTextField.placeholder = "닉네임을 입력해주세요!"
        nickTextField.font = .neoMedium(ofSize: 16)
        
    }
}
