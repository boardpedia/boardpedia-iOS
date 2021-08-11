//
//  GameManualVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/31.
//

import UIKit

class GameManualVC: UIViewController {
    
    var heightDelegate: ChangeHeightDelegate?
    var similarGameData: [TrendingGame] = []
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var objectiveLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var headcountLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    
    @IBOutlet weak var similarLabel: UILabel!
    @IBOutlet weak var similarCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        similarCollectionView.delegate = self
        similarCollectionView.dataSource = self
//        similarCollectionView.isScrollEnabled = true
        similarCollectionView.backgroundColor = .none
    }
    
    override func viewDidLayoutSubviews() {
        heightDelegate?.GiveHeight(value: 350)
        // 동적 위치 전달
    }
    
}

extension GameManualVC {
    
    func setData(name: String, objective: String, time: String, playerNum: Int, maxPlayerNum: Int, level: String, method: String, tip: String, gameIdx: Int) {
        
        nameLabel.setLabel(text: name, font: .neoBold(ofSize: 20))
        objectiveLabel.setLabel(text: objective, font: .neoMedium(ofSize: 16))
        objectiveLabel.numberOfLines = 0
        
        timeLabel.setLabel(text: "총 플레이 \(time) 소요", font: .neoMedium(ofSize: 16))
        
        if maxPlayerNum != 0 {
            if maxPlayerNum == playerNum {
                headcountLabel.setLabel(text: "\(maxPlayerNum)인", font: .neoMedium(ofSize: 16))
            } else {
                headcountLabel.setLabel(text: "\(playerNum)~\(maxPlayerNum)인", font: .neoMedium(ofSize: 16))
            }
        } else {
            headcountLabel.setLabel(text: "\(playerNum)인", font: .neoMedium(ofSize: 16))
        }
        
        levelLabel.setLabel(text: level, font: .neoMedium(ofSize: 16))
        
        similarLabel.setLabel(text: "\(name)과 비슷해요", font: .neoBold(ofSize: 18))
        
        if NetworkState.isConnected() {
            if let token = UserDefaults.standard.string(forKey: "UserToken") {
                
                APIService.shared.getSimilarGame(token, gameIdx) { [self] result in
                    switch result {
                    
                    case .success(let data):
                        
                        similarGameData = data
                        similarCollectionView.reloadData()
                        
                    case .failure(let error):
                        print(error)
                        
                    }
                }
            }
        } else {
            // 네트워크 미연결시
            
            self.showNetworkModal()
        }
        
        
    }
}


// MARK: UICollectionViewDelegateFlowLayout

extension GameManualVC: UICollectionViewDelegateFlowLayout {
    // CollectionView 크기 잡기
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 한 아이템의 크기
        
        return CGSize(width: 120/375 * self.view.frame.width, height: 149/375*self.view.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // collectionView와 View 간의 간격
        
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        
    }
    
}

// MARK: UICollectionViewDataSource

extension GameManualVC: UICollectionViewDataSource {
    // CollectionView 데이터 넣기
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarGameData.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarGameCell.identifier, for: indexPath) as? SimilarGameCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(image: similarGameData[indexPath.row].imageURL, name: similarGameData[indexPath.row].name)
        return cell
        
    }
    
    
}

