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
    @IBOutlet weak var subView: UIView!
    
    // MARK: IBAction

    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setSubView()
        setProfile()
        // Do any additional setup after loading the view.
    }

    
}

// MARK: Extension

extension MypageVC {
    
    // MARK: List View Insert Function
    
    func setSubView() {
        let vc = self.storyboard!.instantiateViewController(identifier: "SwipeVC")
        self.addChild(vc)
        
        self.subView.addSubview(vc.view)
        vc.view.frame = self.subView.bounds
        vc.willMove(toParent: self)
        vc.didMove(toParent: self)
    }
    
    // MARK: Profile Style Function
    
    func setProfile() {
        
        profileImageView.image = UIImage(named: "profile")
        nickLabel.setLabel(text: "미니", font: .neoBold(ofSize: 20))
        levelButton.setButton(text: "보드초보자", color: .boardOrange, font: .neoMedium(ofSize: 15), backgroundColor: UIColor(red: 1.0, green: 119.0 / 255.0, blue: 72.0 / 255.0, alpha: 0.1))
        levelButton.setRounded(radius: 12)
        levelButton.setBorder(borderColor: .boardOrange, borderWidth: 1)
    }
    
}
