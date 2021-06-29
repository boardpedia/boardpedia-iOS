//
//  MySaveListVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/12.
//

import UIKit

class MySaveListVC: UIViewController {

    // MARK: Variable Part
    
    var saveListData: [GameDate] = []
    
    // MARK: IBOutlet
    
    @IBOutlet weak var saveListCollectionView: UICollectionView!
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.string(forKey: "UserSnsId") == "1234567" {
            // 비회원이라면
            setGoLogin()
            
        } else {
            setResultCollectionView()
        }
       
        // Do any additional setup after loading the view.
    }

}

// MARK: Extension

extension MySaveListVC {
    
    // MARK: Result Data Style Function
    
    func setResultCollectionView() {
        
        // Test Data (서버 연결 전)
        let item1 = GameDate(gameImage: "testImage", gameName: "보드게임 이름이 길면 어떨까요~", gameExplain: "만약에 설명이 길어지면 어떻게 될까요? 저는 궁금해요 선생님~")
        let item2 = GameDate(gameImage: "testImage", gameName: "할리갈리", gameExplain: "할리갈리 해볼리?")
        let item3 = GameDate(gameImage: "testImage", gameName: "루미큐브", gameExplain: "루미큐브 해보큐?")
        saveListData.append(contentsOf: [item1,item2,item3,item1,item2,item3,item1,item2,item3,item1,item2,item3])
        
        
        saveListCollectionView.delegate = self
        saveListCollectionView.dataSource = self
        saveListCollectionView.backgroundColor = .boardWhite
    }
    
    func setGoLogin() {
        
        let infoLabel = UILabel()
        self.view.addSubview(infoLabel)
        
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        infoLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        infoLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        infoLabel.setLabel(text: "더 많은 기능을 사용하고 싶다면?", font: .neoMedium(ofSize: 16))
        
        
        let brandImage = UIImageView()
        self.view.addSubview(brandImage)
        
        brandImage.translatesAutoresizingMaskIntoConstraints = false
        
        brandImage.widthAnchor.constraint(equalToConstant: 104/375 * self.view.frame.width).isActive = true
        brandImage.heightAnchor.constraint(equalToConstant: 104/375 * self.view.frame.width).isActive = true
        brandImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        brandImage.bottomAnchor.constraint(equalTo: infoLabel.topAnchor, constant: -25).isActive = true
        
        brandImage.image = UIImage(named: "charcter")
        
        let loginButton = UIButton()
        self.view.addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.widthAnchor.constraint(equalToConstant: 164/375 * self.view.frame.width).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40/375 * self.view.frame.width).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 30).isActive = true
        
        loginButton.setButton(text: "지금 로그인 하러가기", color: .boardOrange, font: .neoSemiBold(ofSize: 16), backgroundColor: .boardWhite)
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
        
        cell.configure(image: saveListData[indexPath.row].gameImage, name: saveListData[indexPath.row].gameName, info: saveListData[indexPath.row].gameExplain)
        return cell
        
    }
    
}
