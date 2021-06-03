//
//  GameManualVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/31.
//

import UIKit

class GameManualVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var objectiveLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var headcountLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    
    @IBOutlet weak var methodLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension GameManualVC {
    
    func setData(name: String, objective: String, time: Int, headcount: String, level: String, method: String) -> CGFloat {
        
        nameLabel.setLabel(text: name, font: .neoBold(ofSize: 20))
        objectiveLabel.setLabel(text: objective, font: .neoMedium(ofSize: 16))
        objectiveLabel.numberOfLines = 0
        
        timeLabel.setLabel(text: "총 플레이 \(time)분 소요", font: .neoMedium(ofSize: 16))
        headcountLabel.setLabel(text: headcount, font: .neoMedium(ofSize: 16))
        levelLabel.setLabel(text: level, font: .neoMedium(ofSize: 16))
        
        methodLabel.lineSetting(lineSpacing: 5)
        methodLabel.textAlignment = .left
        methodLabel.setLabel(text: method, font: .neoMedium(ofSize: 16))
        methodLabel.numberOfLines = 0
        
        return self.view.frame.height
    }
    
}
