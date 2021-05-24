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
        
        setResultTableView()
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
