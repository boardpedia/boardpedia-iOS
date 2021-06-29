//
//  MypageVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/11.
//

import UIKit

class MypageVC: UIViewController {
    
    // MARK: Variable Part
    
    var userData: UserData?
    
    // MARK: IBOutlet
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nickLabel: UILabel!
    @IBOutlet weak var levelButton: UIButton!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var editButton: UIButton!
    
    
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
        let vc = self.storyboard!.instantiateViewController(identifier: "SwipeListVC")
        self.addChild(vc)
        
        self.subView.addSubview(vc.view)
        vc.view.frame = self.subView.bounds
        vc.willMove(toParent: self)
        vc.didMove(toParent: self)
    }
    
    // MARK: Profile Style Function
    
    func setProfile() {
        
        levelButton.setRounded(radius: 12)
        
        if UserDefaults.standard.string(forKey: "UserSnsId") == "1234567" {
            // 비회원이라면
            
            nickLabel.setLabel(text: "로그인을 해보세요", font: .neoBold(ofSize: 20))
            levelButton.setButton(text: "브론즈", color: .boardGray30, font: .neoMedium(ofSize: 15), backgroundColor: .boardGray)
            levelButton.setBorder(borderColor: .boardGray30, borderWidth: 1)
            profileImageView.image = UIImage(named: "level1ProfileImg")
            editButton.isHidden = true
            
        } else {
            // 로그인을 했다면
            
            levelButton.setBorder(borderColor: .boardOrange, borderWidth: 1)
            editButton.isHidden = false
            
            if NetworkState.isConnected() {
                // 네트워크 연결 시
                
                if let token = UserDefaults.standard.string(forKey: "UserToken") {
                    
                    APIService.shared.searchUser(token) { [self] result in
                        switch result {
                        
                        case .success(let data):
                            
                            userData = data
                            
                            if let userData = userData {
                                nickLabel.setLabel(text: userData.nickName, font: .neoBold(ofSize: 20))
                                levelButton.setButton(text: userData.level, color: .boardOrange, font: .neoMedium(ofSize: 15), backgroundColor: UIColor(red: 1.0, green: 119.0 / 255.0, blue: 72.0 / 255.0, alpha: 0.1))
                                
                                profileImageView.image = UIImage(named: "profile")
                                // 레벨별로 이미지 달라야해서 이거 수정해야함! 꼬옥!
                                
                            }
                            
                        case .failure(let error):
                            print(error)
                            
                        }
                        
                    }
                }
                
            } else {
                
                // 네트워크 미연결 팝업
            }
            
        }
        
    }
    
    
    
    
}
