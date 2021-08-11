//
//  ReviewAddVC.swift
//  boardpedia
//
//  Created by Hailey on 2021/08/10.
//

import UIKit
import Cosmos

class ReviewAddVC: UIViewController {

    var keyword: [String] = ["간단한", "클래식", "롤플레이", "전략", "심리", "스피드", "파티", "스릴만점", "모험", "운빨", "주사위", "카드", "견제", "협상", "퍼즐", "팀전"]
    var keywordSelected = [Bool](repeating: false, count: 16)
    var gameIdx: Int?
    var reloadDataAction : (() -> Void)?
    
    var isSelected: Bool = false { // 체크 버튼 선택 여부
        didSet {
            if isSelected {
                // 동의시
                
                checkLabel.font = .neoSemiBold(ofSize: 15)
                checkLabel.textColor = .boardOrange
                checkButton.setBorder(borderColor: .boardOrange, borderWidth: 1)
                checkButton.setImage(UIImage(named: "checkBtn"), for: .normal)
                
                if starView.rating != 0.0 && keywordSelected.filter({ $0 == true }).count > 0 {
                    // 별점이 존재하고, 키워드를 하나 이상 선택했다면 -> 추가하기 버튼 활성화
                    addButton.isEnabled = true
                    addButton.backgroundColor = .boardOrange
                    addButton.setTitleColor(.boardWhite, for: .normal)
                }
            } else {
                // 미동의시
                
                checkLabel.font = .neoMedium(ofSize: 15)
                checkLabel.textColor = .boardGray50
                checkButton.setBorder(borderColor: .boardGray40, borderWidth: 1)
                checkButton.setImage(nil, for: .normal)
                addButton.isEnabled = false
                addButton.backgroundColor = .boardBlack10
                addButton.setTitleColor(.boardGray30, for: .normal)
            }
        }
    }
    
    @IBOutlet weak var keywordCollectionView: UICollectionView!
    @IBOutlet weak var starView: CosmosView!
    @IBOutlet weak var checkLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var keywordCollectionLayout: UICollectionViewFlowLayout! {
        didSet {
            keywordCollectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    @IBAction func checkButtonDidTap(_ sender: Any) {
        isSelected = !isSelected
        
    }
    
    @IBAction func addButtonDidTap(_ sender: Any) {
        
        var k: Int = 0
        var mykeyword = ["", "", ""]
        
        for i in 0..<keywordSelected.count {
            if keywordSelected[i] {
                mykeyword[k] = keyword[i]
                k += 1
            }
        }
        addButton.isEnabled = false
        
        if NetworkState.isConnected() {
            if let token = UserDefaults.standard.string(forKey: "UserToken"),
               let gameIdx = gameIdx {
                
                APIService.shared.postReview(token, gameIdx, Float(starView.rating), mykeyword[0], mykeyword[1], mykeyword[2]) { [self] result in
                    switch result {

                    case .success(_):

                        let storyboard = UIStoryboard(name: "Modal", bundle: nil)
                        guard let popUpVC =
                                storyboard.instantiateViewController(identifier: "PopUpVC") as? PopUpVC else {return}
                        
                        popUpVC.modalPresentationStyle = .overCurrentContext
                        popUpVC.modalTransitionStyle = .crossDissolve
                        self.present(popUpVC, animated: true, completion: nil)
                        popUpVC.titleLabel.text = "소중한 보드게임 리뷰가\n보드피디아에 등록되었어요!"
                        popUpVC.subLabel.text = "다른 게임의 리뷰도 작성해보세요."
                        
                        popUpVC.popButtonAction = {
                            // closure 호출
                            
                            self.dismiss(animated: true)
                            
                            guard let reloadDataAction = self.reloadDataAction else {
                                return
                            }
                            
                            reloadDataAction()
                        }
                        
                        
                    case .failure(let error):
                        if error == 404 {
                            showToast(message: "이미 리뷰가 등록된 게임이에요!", font: .neoBold(ofSize: 15), width: 240, bottomY: 50)
                        }
                        addButton.isEnabled = true

                    }
                }
            }
        } else {
            // 네트워크 미연결시
            
            self.showNetworkModal()
        }
        
       
    }
    
    @IBAction func cancleButtonDidTap(_ sender: Any) {
        // 뷰 내리기
        
        self.dismiss(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStar()
        setView()
    }


}

extension ReviewAddVC {
    
    func setView() {
        
        checkButton.setRounded(radius: 4)
        checkButton.setBorder(borderColor: .boardGray40, borderWidth: 1)
        checkButton.backgroundColor = .white
        checkLabel.textColor = .boardGray50
        
        keywordCollectionView.delegate = self
        keywordCollectionView.dataSource = self
        
        let customLayout = LeftAlignFlowLayout()
        keywordCollectionView.collectionViewLayout = customLayout
        customLayout.estimatedItemSize = CGSize(width: 40, height: 20)
        
        addButton.setRounded(radius: 8)
        addButton.isEnabled = false
        addButton.backgroundColor = .boardBlack10
        addButton.setTitleColor(.boardGray30, for: .normal)
        
    }
    
    func setStar() {
        // 별점 관리
        
        starView.rating = 0
        starView.settings.starSize = 40
        starView.settings.starMargin = 12
        starView.didFinishTouchingCosmos  = { rating in
            if self.isSelected && self.keywordSelected.filter({ $0 == true }).count > 0 {
                // 동의 버튼을 클릭 한 상태라면 -> 추가하기 버튼 활성화
                
                self.addButton.isEnabled = true
                self.addButton.backgroundColor = .boardOrange
                self.addButton.setTitleColor(.boardWhite, for: .normal)
            }
        }
        
    }
}



// MARK: UICollectionViewDelegateFlowLayout

extension ReviewAddVC: UICollectionViewDelegateFlowLayout {
    // CollectionView 크기 잡기
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 한 아이템의 크기
        
        return CGSize(width: 67, height: 28)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 15
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // collectionView와 View 간의 간격
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    
}

// MARK: UICollectionViewDataSource

extension ReviewAddVC: UICollectionViewDataSource {
    // CollectionView 데이터 넣기
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return keyword.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == keywordCollectionView {
            
            if keywordSelected[indexPath.row] {
                keywordSelected[indexPath.row] = !keywordSelected[indexPath.row]
                keywordCollectionView.reloadData()
            } else {
                if keywordSelected.filter({ $0 == true }).count < 3 {
                    keywordSelected[indexPath.row] = !keywordSelected[indexPath.row]
                    keywordCollectionView.reloadData()
                }
            }
            
            if starView.rating != 0.0 && isSelected && keywordSelected.filter({ $0 == true }).count > 0 {
                // 별점이 존재하고, 동의 버튼을 클릭했다면 -> 추가하기 버튼 활성화
                addButton.isEnabled = true
                addButton.backgroundColor = .boardOrange
                addButton.setTitleColor(.boardWhite, for: .normal)
            } else {
                addButton.isEnabled = false
                addButton.backgroundColor = .boardBlack10
                addButton.setTitleColor(.boardGray30, for: .normal)
            }
            
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeKeywordCell.identifier, for: indexPath) as? ThemeKeywordCell else {
            return UICollectionViewCell()
        }
        
        if keywordSelected[indexPath.row] {
            // true 라면 -> 선택되었다면
            
            cell.contentView.backgroundColor = .boardOrange
            cell.keywordLabel.textColor = .white
        } else {
            // false 라면 -> 미선택되었다면
            
            cell.contentView.backgroundColor = .white
            cell.keywordLabel.textColor = .boardOrange
        }
        cell.keywordLabel.text = keyword[indexPath.row]
        return cell
        
    }
    
}
@IBDesignable
class GRCustomButton: UIButton {

    @IBInspectable var margin:CGFloat = 278.0
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        //increase touch area for control in all directions by 20

        let area = self.bounds.insetBy(dx: -margin, dy: 0)
        return area.contains(point)
    }

}
