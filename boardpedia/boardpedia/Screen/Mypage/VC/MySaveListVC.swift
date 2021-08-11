//
//  MySaveListVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/12.
//

import UIKit

class MySaveListVC: UIViewController {

    // MARK: Variable Part
    
    var saveListData: [UserSaveListData] = [] {
        didSet {
            if saveListData.count == 0 {
                // 데이터가 없는 경우
                if UserDefaults.standard.string(forKey: "UserSnsId") == "1234567" {
                    // 비회원이라면
                    infoLabel.setLabel(text: "더 많은 기능을 사용하고 싶다면?", font: .neoMedium(ofSize: 16))
                    loginButton.setButton(text: "지금 로그인 하러가기", color: .boardOrange, font: .neoSemiBold(ofSize: 16), backgroundColor: .boardWhite)
                    
                } else {
                    // 회원이지만, 데이터가 없다면
                    infoLabel.setLabel(text: "아직 저장한 게임이 없어요.", font: .neoMedium(ofSize: 16))
                    loginButton.setButton(text: "지금 저장 하러가기", color: .boardOrange, font: .neoSemiBold(ofSize: 16), backgroundColor: .boardWhite)
                }
                infoLabel.isHidden = false
                brandImage.isHidden = false
                loginButton.isHidden = false
            } else {
                // 데이터가 존재하는 경우
                
                infoLabel.isHidden = true
                brandImage.isHidden = true
                loginButton.isHidden = true
            }
        }
    }
    
    var infoLabel = UILabel()
    var brandImage = UIImageView()
    var loginButton = UIButton()
    
    // MARK: IBOutlet
    
    @IBOutlet weak var saveListCollectionView: UICollectionView!
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGoLogin()
        setViewStyle()
       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if UserDefaults.standard.string(forKey: "UserSnsId") != "1234567" {
            // 비회원이 아니라면
            
            setResultCollectionView()
        } else {
            
            infoLabel.setLabel(text: "더 많은 기능을 사용하고 싶다면?", font: .neoMedium(ofSize: 16))
            loginButton.setButton(text: "지금 로그인 하러가기", color: .boardOrange, font: .neoSemiBold(ofSize: 16), backgroundColor: .boardWhite)
        }
        
    }

}

// MARK: Extension

extension MySaveListVC {
    
    // MARK: View Default Style Function
    
    func setViewStyle() {
        
        saveListCollectionView.delegate = self
        saveListCollectionView.dataSource = self
        saveListCollectionView.backgroundColor = .boardWhite
        
    }
    
    // MARK: Result Data Style Function
    
    func setResultCollectionView() {
        
        if NetworkState.isConnected() {
            // 네트워크 연결 시
            
            if let token = UserDefaults.standard.string(forKey: "UserToken") {
                
                APIService.shared.mySaveList(token) { [self] result in
                    switch result {
                    
                    case .success(let data):
                        
                        saveListData = data
                        saveListCollectionView.reloadData()
                    
                    case .failure(let error):
                        print(error)
                        
                    }
                    
                }
            }
            
        } else {
            // 네트워크 미연결 팝업 띄우기
            
            self.showNetworkModal()
            
        }
    }
    
    func setGoLogin() {
        
        self.view.addSubview(infoLabel)
        
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        infoLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        infoLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        self.view.addSubview(brandImage)
        
        brandImage.translatesAutoresizingMaskIntoConstraints = false
        
        brandImage.widthAnchor.constraint(equalToConstant: 104/375 * self.view.frame.width).isActive = true
        brandImage.heightAnchor.constraint(equalToConstant: 104/375 * self.view.frame.width).isActive = true
        brandImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        brandImage.bottomAnchor.constraint(equalTo: infoLabel.topAnchor, constant: -25).isActive = true
        
        brandImage.image = UIImage(named: "grayCharcter")
        
        self.view.addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.widthAnchor.constraint(equalToConstant: 164/375 * self.view.frame.width).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40/375 * self.view.frame.width).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 30).isActive = true
        
        loginButton.setBorder(borderColor: .boardOrange, borderWidth: 1)
        loginButton.setRounded(radius: 6)
        
        
    }
}


// MARK: UICollectionViewDelegateFlowLayout

extension MySaveListVC: UICollectionViewDelegateFlowLayout {
    // CollectionView 크기 잡기
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 한 아이템의 크기
        
        let itemWidth = (self.view.frame.width-32)/2 - 7.5
        return CGSize(width: itemWidth, height: 139/164 * itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // 아이템간의 간격
        
        return 15
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // collectionView와 View 간의 간격
        
        return UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
        
    }
    
}

// MARK: UICollectionViewDataSource

extension MySaveListVC: UICollectionViewDataSource {
    // CollectionView 데이터 넣기
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return saveListData.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MySaveListCell.identifier, for: indexPath) as? MySaveListCell else {
            return UICollectionViewCell()
        }
        
        cell.cellDelegate = self
        cell.cellIndex = indexPath
        
        cell.configure(image: saveListData[indexPath.row].boardGame.imageURL, name: saveListData[indexPath.row].boardGame.name, info: saveListData[indexPath.row].boardGame.intro)
        
        return cell
        
    }
    
}


extension MySaveListVC: BookmarkCellDelegate {
    func BookmarkCellGiveIndex(_ cell: UICollectionViewCell, didClickedIndex value: Int) {
        
        if NetworkState.isConnected() {
            
            if let token = UserDefaults.standard.string(forKey: "UserToken") {
                // 토큰 존재 시
                
                APIService.shared.saveCancleGame(token, saveListData[value].boardGame.gameIdx) { [self] result in
                    switch result {
                    
                    case .success(_):
                        
                        setResultCollectionView()
                       
                        
                    case .failure(let error):
                        print(error)
                        
                    }
                    
                }
                
            }
            
        } else {
            // 네트워크 미연결 팝업 띄우기
            
            self.showNetworkModal()
            
        }
        
        
    }
}
