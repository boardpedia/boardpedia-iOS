//
//  GameReviewVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/06/03.
//

import UIKit
import Cosmos

class GameReviewVC: UIViewController {

    var reviewData: ReviewData?
    var gameIdx: Int?
    
    var logoImage = UIImageView()
    var noDataLabel = UILabel()
    
    @IBOutlet weak var totalView: UIView!
    
    @IBOutlet weak var averageStarLabel: UILabel!
    @IBOutlet weak var starView: CosmosView!
    @IBOutlet weak var topKeywordCollectionView: UICollectionView!

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var writeButton: UIButton!
    
    @IBOutlet weak var reviewTableView: UITableView!
    
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            // 동적 사이즈를 주기 위해 estimatedItemSize 를 사용했다. 대략적인 셀의 크기를 먼저 조정한 후에 셀이 나중에 AutoLayout 될 때, 셀의 크기가 변경된다면 그 값이 다시 UICollectionViewFlowLayout에 전달되어 최종 사이즈가 결정되게 된다.
        }
    }
    
    @IBAction func writeButtonDidTap(_ sender: Any) {
        // 비회원은 못쓰게 막아야함
        
        if UserDefaults.standard.string(forKey: "UserSnsId") != "1234567" {
            // 비회원이 아니라면?
            
            writeReviewAction()
        } else {
            // 비회원이라면 ?
            
            let nextStoryboard = UIStoryboard(name: "Login", bundle: nil)
            guard let popUpVC = nextStoryboard.instantiateViewController(identifier: "LoginPopupVC") as? LoginPopupVC else { return }
            
            self.present(popUpVC, animated: true, completion: nil)
            // 로그인 유도 팝업 띄우기
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        if let gameIdx = gameIdx {
            setData(gameIdx: gameIdx)
        }
        // Do any additional setup after loading the view.
    }
    

}

extension GameReviewVC {
    
    func setView() {
        
        self.topKeywordCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.reviewTableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.totalView.setRounded(radius: 6)
        
        writeButton.setButton(text: "후기쓰기", color: .boardOrange, font: .neoBold(ofSize: 16), backgroundColor: .clear)
        
        let layout = topKeywordCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        
        
        // topKeywordCollectionView cell 가운데 정렬
        let columnLayout = UICollectionViewCenterLayout()
        columnLayout.estimatedItemSize = CGSize(width: 140, height: 40)
        topKeywordCollectionView.collectionViewLayout = columnLayout
    
        
        topKeywordCollectionView.delegate = self
        topKeywordCollectionView.dataSource = self
        
        topKeywordCollectionView.backgroundColor = .clear
        
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableView.backgroundColor = .clear
        
        starView.settings.starSize = 20
        starView.settings.starMargin = 3
        starView.backgroundColor = .clear
        starView.settings.updateOnTouch = false
        
    }
    
    func setData(gameIdx: Int) {
        
        if NetworkState.isConnected() {
            if let token = UserDefaults.standard.string(forKey: "UserToken") {
                
                APIService.shared.getReview(token, gameIdx) { [self] result in
                    switch result {
                    
                    case .success(let data):
                        
                        reviewData = data
                        
                        if let data = reviewData {
                            
                            countLabel.setLabel(text: "후기 \(data.reviews.count)개", font: .neoMedium(ofSize: 16))
                            averageStarLabel.setLabel(text: "\(data.reviewInfo.averageStar)", font: .neoSemiBold(ofSize: 33))
                            
                            if data.reviewInfo.topKeywords.count == 0 {
                                starView.rating = 0.0
                                
                                topKeywordCollectionView.reloadData()
                                setNoDataView()
                                
                                view.reloadInputViews()
                                
                                
                            } else {
                                
                                averageStarLabel.setLabel(text: "\(data.reviewInfo.averageStar)", font: .neoSemiBold(ofSize: 33))
                                starView.rating = data.reviewInfo.averageStar
                                topKeywordCollectionView.reloadData()
                                
                                logoImage.removeFromSuperview()
                                noDataLabel.removeFromSuperview()
                                
                                view.reloadInputViews()
                                
                                reviewTableView.reloadData()
                                
                                self.reviewTableView.heightAnchor.constraint(equalToConstant: CGFloat(data.reviews.count*100)).isActive = true

                            }
                            
                            if data.reviewInfo.topKeywords.count > 2 {
                                
                                self.topKeywordCollectionView.heightAnchor.constraint(equalToConstant: 70).isActive = true
                                
                            } else {
                                
                                self.topKeywordCollectionView.heightAnchor.constraint(equalToConstant: 30).isActive = true
                            }
                        
                            
                        }
                        
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
    
    func setNoDataView() {
        
        self.view.addSubview(logoImage)
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.widthAnchor.constraint(equalToConstant: 90/375 * self.view.frame.width).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 90/375 * self.view.frame.width).isActive = true
        logoImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        logoImage.topAnchor.constraint(equalTo: self.countLabel.bottomAnchor, constant: 40).isActive = true
        
        logoImage.image = UIImage(named: "brandNoDataChacter")
        
        self.view.addSubview(noDataLabel)
        
        noDataLabel.translatesAutoresizingMaskIntoConstraints = false
        noDataLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        noDataLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 25).isActive = true
        noDataLabel.lineSetting(lineSpacing: 5)
        noDataLabel.setLabel(text: "아직 후기가 없어요.\n첫번째로 후기를 남겨보세요!", font: .neoMedium(ofSize: 16))
        noDataLabel.numberOfLines = 0
        noDataLabel.textAlignment = .center
    }
    
    @objc func hi() {
        print("hihi")
    }
    
    @objc func writeReviewAction() {
        // 후기 쓰기 버튼으로 이동
        
        guard let reviewAddVC = self.storyboard?.instantiateViewController(identifier: "ReviewAddVC") as? ReviewAddVC else {
            return
        }
        reviewAddVC.modalPresentationStyle = .fullScreen
        self.present(reviewAddVC, animated: true)
        reviewAddVC.gameIdx = gameIdx
        reviewAddVC.reloadDataAction = {
            if let gameIdx = self.gameIdx {
                self.setData(gameIdx: gameIdx)
            }
        }
        
    }
    
}


// MARK: UICollectionViewDelegateFlowLayout

extension GameReviewVC: UICollectionViewDelegateFlowLayout {
    // CollectionView 크기 잡기
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 한 아이템의 크기
        
        return CGSize(width: 78, height: 30)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // 아이템간의 간격
        
        return 10
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // collectionView와 View 간의 간격
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    
}

// MARK: UICollectionViewDataSource

extension GameReviewVC: UICollectionViewDataSource {
    // CollectionView 데이터 넣기
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let data = reviewData {
            
            if data.reviewInfo.topKeywords.count == 0 {
                
                return 1
            }
            return data.reviewInfo.topKeywords.count
        }
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeKeywordCell.identifier, for: indexPath) as? ThemeKeywordCell else {
            return UICollectionViewCell()
        }
        
        if let data = reviewData {
            
            if data.reviewInfo.topKeywords.count == 0 {
                
                cell.keywordLabel.text = "#후기없음"
                cell.keywordLabel.textColor = .boardGray40
                cell.contentView.layer.borderColor = UIColor.boardGray40.cgColor
                
            } else {
                
                cell.keywordLabel.text = "# \(data.reviewInfo.topKeywords[indexPath.row])"
                
            }
            
            
        }
        
        return cell
        
        
    }
    
}



// MARK: UITableViewDataSource

extension GameReviewVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let data = reviewData {
            return data.reviews.count
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GameReviewCell.identifier, for: indexPath) as? GameReviewCell else { return UITableViewCell() }
        
        if let data = reviewData {
            
            cell.configure(nick: data.reviews[indexPath.row].nickName, star: data.reviews[indexPath.row].star, keyword: data.reviews[indexPath.row].keyword, date: data.reviews[indexPath.row].createdAt, level: data.reviews[indexPath.row].level)
        }
        
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    
}

// MARK: UITableViewDelegate

extension GameReviewVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
