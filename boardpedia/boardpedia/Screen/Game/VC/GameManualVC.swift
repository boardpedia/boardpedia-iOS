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
    
    var loadCompletion: (CGFloat) -> Void = { _ in }
    var gameDetail: GameDetailData?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension GameManualVC {
    
//    func setData() {
//
//        let item = GameDetailData(gameIdx: 2, name: "다이아몬드 게임", intro: "내 말을 움직여 반대편의 우리집으로 먼저 옮기자!", imageURL: "https://www.koreaboardgames.com/upload/uploaded/prd/639261505700784.png", tag: ["유명한", "간단한", "클래식"], saved: 1, star: 3.5, objective: "도로, 마을과 도시, 교역로와 기사를 이용하여 가장 먼저 10점을 달성하세요. 상대방이 필요한 자원이 무엇인지 파악하고, 유리하게 거래에 이용해보세요!", webURL: "https://www.koreaboardgames.com/upload/uploaded/prd/639261505700784", method: "1. 맵을 구성하고 구성물을 나눠 가지세요.\n2. 플레이어 당 마을 2개와 도로 2개를 놓아 근거지를 정하세요.\n3. 주사위를 굴려 자원을 획득합니다.\n4. 자원을 교환하고 필요한 건물을 건설하여 영역을 확장해 나가보세요!")
//
//        gameDetail = item
//
//        if let data = gameDetail {
//
//            nameLabel.setLabel(text: data.name, font: .neoBold(ofSize: 20))
//            objectiveLabel.setLabel(text: data.objective, font: .neoMedium(ofSize: 16))
//            objectiveLabel.numberOfLines = 0
//
//            timeLabel.setLabel(text: "총 플레이 20분 소요", font: .neoMedium(ofSize: 16))
//            headcountLabel.setLabel(text: "최대 2인", font: .neoMedium(ofSize: 16))
//            levelLabel.setLabel(text: "하", font: .neoMedium(ofSize: 16))
//
//            methodLabel.setLabel(text: ㅇㅁethod, font: .neoMedium(ofSize: 16))
//            methodLabel.numberOfLines = 0
//        }
//    }
    
    func setData(name: String, objective: String, time: Int, headcount: String, level: String, method: String) {
        
        nameLabel.setLabel(text: name, font: .neoBold(ofSize: 20))
        objectiveLabel.setLabel(text: objective, font: .neoMedium(ofSize: 16))
        objectiveLabel.numberOfLines = 0
        
        timeLabel.setLabel(text: "총 플레이 \(time)분 소요", font: .neoMedium(ofSize: 16))
        headcountLabel.setLabel(text: headcount, font: .neoMedium(ofSize: 16))
        levelLabel.setLabel(text: level, font: .neoMedium(ofSize: 16))
        
        methodLabel.setLabel(text: method, font: .neoMedium(ofSize: 16))
        methodLabel.numberOfLines = 0
        loadCompletion(self.view.frame.height)
    }
    
}
