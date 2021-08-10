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
    @IBOutlet weak var levelCollectionView: UICollectionView!
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var editButton: UIButton!
    
    
    // MARK: IBAction
    
    @IBAction func settingButtonDidTap(_ sender: Any) {
        
        let storyboard = UIStoryboard.init(name: "Setting", bundle: nil)
        guard let settingVC = storyboard.instantiateViewController(identifier: "SettingListVC") as? SettingListVC else {
            return
        }
        
        self.navigationController?.pushViewController(settingVC, animated: true)
        // 설정 뷰로 이동
        
    }
    
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
        
        let layout = levelCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .vertical
        levelCollectionView.delegate = self
        levelCollectionView.dataSource = self
        levelCollectionView.backgroundColor = .none
        
        let customLayout = LeftAlignFlowLayout()
        levelCollectionView.collectionViewLayout = customLayout
        customLayout.estimatedItemSize = CGSize(width: 41, height: 41)
    }
    
    // MARK: Profile Style Function
    
    func setProfile() {
        
        if UserDefaults.standard.string(forKey: "UserSnsId") == "1234567" {
            // 비회원이라면
            
            nickLabel.setLabel(text: "로그인을 해보세요", font: .neoBold(ofSize: 20))
            profileImageView.image = UIImage(named: "level1ProfileImg")
            editButton.isHidden = true
            
        } else {
            // 로그인을 했다면
            
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
                                levelCollectionView.reloadData()
                                
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


// MARK: UICollectionViewDelegateFlowLayout

extension MypageVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 한 아이템의 크기
        
        let itemWidth = self.view.frame.width - 32
        return CGSize(width: itemWidth, height: 120/343 * itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // 아이템간의 간격
        
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // collectionView와 View 간의 간격
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        
    }
    
    
}

// MARK: UICollectionViewDataSource

extension MypageVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeKeywordCell.identifier, for: indexPath) as? ThemeKeywordCell else {
            return UICollectionViewCell()
        }
        
        if let userData = userData {
            cell.nickConfigure(level: userData.level, login: true)
        } else {
            cell.nickConfigure(level: "브론즈", login: false)
        }
    
        return cell
    }
    
    
}
