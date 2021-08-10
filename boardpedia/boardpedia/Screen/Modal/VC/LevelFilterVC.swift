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
    var levelBool: [Bool] = [false, false, false]
    var levelFilterAction : ((String) -> Void)? // closer 변수
    var myLevel: Int?
    
    // MARK: IBOutlet
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var levelTableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        levelTableView.delegate = self
        levelTableView.dataSource = self
        
        if let level = myLevel {
            
            levelBool[level] = true
        }
        

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 뷰 클릭 시 뷰 내리기
        
        self.dismiss(animated: true)
        
        if let myLevel = myLevel {
            guard let levelFilterAction = self.levelFilterAction else {
                return
            }
            
            if myLevel == -1 {
                levelFilterAction("")
            } else {
                levelFilterAction(self.level[myLevel])
            }
        
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
        
        print(levelBool)
        
        if levelBool[indexPath.row] {
            // 선택된 상태라면?
            
            cell.contentView.backgroundColor = UIColor(red: 1.0, green: 119.0 / 255.0, blue: 72.0 / 255.0, alpha: 0.1)
            cell.levelLabel.textColor = .boardOrange
            cell.levelLabel.font =  UIFont.neoSemiBold(ofSize: 16)
        
        } else {
            // 미선택된 상태라면?
            
            cell.contentView.backgroundColor = .boardWhite
            cell.levelLabel.textColor = .black
            cell.levelLabel.font =  UIFont.neoMedium(ofSize: 16)
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if levelBool[indexPath.row] {
            // 선택상태였는데 다시 선택했다면? -> 선택을 취소한 것
            
            levelBool[indexPath.row] = !levelBool[indexPath.row]
            myLevel = -1
            
        } else {
            // 미선택된것을 다시 선택했다면? -> 이전에 선택된것이 있다면 그걸 취소해야함(초기화)
            
            levelBool = [false, false, false]
            levelBool[indexPath.row] = true
            myLevel = indexPath.row
            
        }
        
        levelTableView.reloadData()
    }
    
    
}

// MARK: UITableViewDelegate

extension LevelFilterVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    
}
