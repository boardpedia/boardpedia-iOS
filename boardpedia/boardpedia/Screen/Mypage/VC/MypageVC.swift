//
//  MypageVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/11.
//

import UIKit

class MypageVC: UIViewController {
    
    // MARK: Variable Part
    
    // MARK: IBOutlet

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nickLabel: UILabel!
    @IBOutlet weak var levelButton: UIButton!
    
    @IBOutlet weak var saveListButton: UIButton!
    @IBOutlet weak var reviewListButton: UIButton!
    
    @IBOutlet weak var listView: UIView!
    
    // MARK: IBAction
    
    @IBAction func saveListButtonDidTap(_ sender: Any) {
        
        saveListButton.setButton(text: "저장 목록", font: .neoSemiBold(ofSize: 16))
        reviewListButton.setButton(text: "후기 목록", color: .boardGray50, font: .neoMedium(ofSize: 16))
        
    }
    
    @IBAction func reviewListButtonDidTap(_ sender: Any) {
        
        reviewListButton.setButton(text: "후기 목록", font: .neoSemiBold(ofSize: 16))
        saveListButton.setButton(text: "저장 목록", color: .boardGray50, font: .neoMedium(ofSize: 16))
    }
    // MARK: Life Cycle Part

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()

        // Do any additional setup after loading the view.
    }
    
}

// MARK: Extension

extension MypageVC {
    
    func setView() {
        saveListButtonDidTap(self)
    }
}
