//
//  MyReviewListVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/12.
//

import UIKit

class MyReviewListVC: UIViewController {
    
    // MARK: Variable Part
    
    var myReviewData: [MyReviewData] = []
    
    @IBOutlet weak var MyReviewListTableView: UITableView!
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.string(forKey: "UserSnsId") == "1234567" {
            // 비회원이라면
            setGoLogin()
            
        } else {
            setResultTableView()
        }
        // Do any additional setup after loading the view.
    }
    
    func setResultTableView() {
        
        MyReviewListTableView.delegate = self
        MyReviewListTableView.dataSource = self
        MyReviewListTableView.backgroundColor = .boardGray
        self.view.backgroundColor = .boardGray
        
        // Test Data (서버 연결 전)
        let item1 = MyReviewData(gameImage: "testImage", gameName: "할리갈리 디럭스", firstKeyword: "스피드", secondKeyword: "꿀잼보장", star: 5)
        let item2 = MyReviewData(gameImage: "testBackImage_2", gameName: "미니미", firstKeyword: "김민희", secondKeyword: "24살", star: 4)
        let item3 = MyReviewData(gameImage: "testBackImage_1", gameName: "보드피디아", firstKeyword: "귀요미", secondKeyword: "3명", star: 3.5)
        myReviewData.append(contentsOf: [item1,item2,item3,item1,item2,item3])
        
        MyReviewListTableView.backgroundColor = .boardGray
        
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


// MARK: UITableViewDataSource

extension MyReviewListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myReviewData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyReviewCell.identifier, for: indexPath) as? MyReviewCell else { return UITableViewCell() }
        
        cell.configure(image: myReviewData[indexPath.row].gameImage, name: myReviewData[indexPath.row].gameName, first: myReviewData[indexPath.row].firstKeyword, second: myReviewData[indexPath.row].secondKeyword, star: myReviewData[indexPath.row].star)
        
        return cell
        
    }
    
    
}

// MARK: UITableViewDelegate

extension MyReviewListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
}
