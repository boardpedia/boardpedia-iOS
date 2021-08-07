//
//  levelFilterVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/08/07.
//

import UIKit

class LevelFilterVC: UIViewController {
    
    // MARK: Variable Part
    
    var level: [String] = ["상","중","하"]
    var levelFilterAction : ((String) -> Void)? // closer 변수
    var myLevel: Int?
    
    // MARK: IBOutlet
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var levelTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        levelTableView.delegate = self
        levelTableView.dataSource = self
        

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 뷰 클릭 시 뷰 내리기
        
        self.dismiss(animated: true)
        
        if let level = myLevel {
            guard let levelFilterAction = self.levelFilterAction else {
                return
            }
            
            levelFilterAction(self.level[level])
        }
    }

}


// MARK: UITableViewDataSource

extension LevelFilterVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return level.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LevelCell.identifier, for: indexPath) as? LevelCell else { return UITableViewCell() }
        
        cell.levelLabel.text = level[indexPath.row]
        cell.selectionStyle = .none
        cell.cellIndex = indexPath
        
        cell.clickIndexAction = {
            text in
            
            self.myLevel = text
            
        }
        
        return cell
        
    }
    
    
}

// MARK: UITableViewDelegate

extension LevelFilterVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    
}
