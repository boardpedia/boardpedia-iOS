//
//  MyReviewListVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/12.
//

import UIKit

class MyReviewListVC: UIViewController {
    
    // MARK: Variable Part
    
    var myReviewData: [UserReviewListData] = []
    var infoLabel = UILabel()
    var brandImage = UIImageView()
    var loginButton = UIButton()
    
    @IBOutlet weak var MyReviewListTableView: UITableView!
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.string(forKey: "UserSnsId") == "1234567" {
            // 비회원이라면
            setEmptyView()
            infoLabel.setLabel(text: "더 많은 기능을 사용하고 싶다면?", font: .neoMedium(ofSize: 16))
            loginButton.setButton(text: "지금 로그인 하러가기", color: .boardOrange, font: .neoSemiBold(ofSize: 16), backgroundColor: .boardWhite)
            
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
        
        if NetworkState.isConnected() {
            // 네트워크 연결 시
            
            if let token = UserDefaults.standard.string(forKey: "UserToken") {
                
                APIService.shared.myReviewList(token) { [self] result in
                    switch result {
                    
                    case .success(let data):
                        myReviewData = data
                        if myReviewData.count == 0 {
                            setEmptyView()
                            infoLabel.setLabel(text: "아직 작성한 후기가 없어요.", font: .neoMedium(ofSize: 16))
                            loginButton.setButton(text: "지금 후기 쓰러가기", color: .boardOrange, font: .neoSemiBold(ofSize: 16), backgroundColor: .boardWhite)
                            
                        } else {
                            MyReviewListTableView.reloadData()
                        }
                       
                        
                    case .failure(let error):
                        print(error)
                        
                    }
                }
            }
        } else {
            // 네트워크 팝업 띄우기
            
        }
        
    }
    
    func setEmptyView() {
        
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
        brandImage.image = UIImage(named: "charcter")
        
       
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


// MARK: UITableViewDataSource

extension MyReviewListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myReviewData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyReviewCell.identifier, for: indexPath) as? MyReviewCell else { return UITableViewCell() }
        
        cell.configure(image: myReviewData[indexPath.row].boardGame.imageURL, name: myReviewData[indexPath.row].boardGame.name, keyword: myReviewData[indexPath.row].keyword, star: myReviewData[indexPath.row].star)
        
        return cell
        
    }
    
    
}

// MARK: UITableViewDelegate

extension MyReviewListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
}
