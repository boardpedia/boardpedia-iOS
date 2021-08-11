//
//  GameAddVC.swift
//  boardpedia
//
//  Created by Hailey on 2021/08/06.
//

import UIKit

class GameAddVC: UIViewController {

    var level: [String] = ["상","중","하"]
    var count: [String] = ["1인","2인 ~ 4인","4인 ~ 6인","잘모르겠어요"]
    var keyword: [String] = ["간단한", "클래식", "롤플레이", "전략", "심리", "스피드", "파티", "스릴만점", "모험", "운빨", "주사위", "카드", "견제", "협상", "퍼즐", "팀전"]
    
    var keywordSelected = [Bool](repeating: false, count: 16)
    
    // MARK: IBOutlet
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var levelCollectionView: UICollectionView!
    @IBOutlet weak var countCollectionView: UICollectionView!
    
    @IBOutlet weak var countCollectionLayout: UICollectionViewFlowLayout! {
        didSet {
            countCollectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    @IBOutlet weak var keywordCollectionView: UICollectionView!
    
    @IBOutlet weak var keywordCollectionLayout: UICollectionViewFlowLayout! {
        didSet {
            keywordCollectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    @IBOutlet weak var addButton: UIButton!
    
    // MARK: IBAction
    
    @IBAction func addButtonDidTap(_ sender: UIButton) {
        // 보드게임 추가하기 버튼 클릭 시 Action
        
        let storyboard = UIStoryboard(name: "Modal", bundle: nil)
        guard let popUpVC =
                storyboard.instantiateViewController(identifier: "PopUpVC") as? PopUpVC else {return}
        
        popUpVC.modalPresentationStyle = .overCurrentContext
        popUpVC.modalTransitionStyle = .crossDissolve
        self.present(popUpVC, animated: true, completion: nil)
        
        popUpVC.popButtonAction = {
            // closure 호출
            
            self.dismiss(animated: true)
        }
        
    }
    
    @IBAction func cancleButtonDidTap(_ sender: Any) {
        // 뷰 내리기
        
        self.dismiss(animated: true)
    }
    
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        scrollViewTap()

    }
    

}

extension GameAddVC {
    
    func setView() {
        
        infoLabel.setLabel(text: "나만 알았던 보드게임을 알려주세요!", color: .black, font: .neoSemiBold(ofSize: 20))
        
        nameTextField.addLeftPadding()
        nameTextField.setRounded(radius: 6)
        nameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
        addButton.setRounded(radius: 8)
        addButton.isEnabled = false
        addButton.backgroundColor = .boardBlack10
        addButton.setTitleColor(.boardGray30, for: .normal)
        
        if let text = infoLabel.text {
            // 앞부분만 폰트와 컬러를 다르게 설정
            
            let changeString: String = "보드게임"
            let attributedStr = NSMutableAttributedString(string: text)
            
            attributedStr.addAttribute(.foregroundColor, value: UIColor.boardOrange, range: (text as NSString).range(of: changeString))
            
            infoLabel.attributedText = attributedStr
        }
        
        levelCollectionView.delegate = self
        levelCollectionView.dataSource = self
        countCollectionView.delegate = self
        countCollectionView.dataSource = self
        keywordCollectionView.delegate = self
        keywordCollectionView.dataSource = self
        
        nameTextField.delegate = self
        
        let customLayout = LeftAlignFlowLayout()
        keywordCollectionView.collectionViewLayout = customLayout
        customLayout.estimatedItemSize = CGSize(width: 40, height: 20)
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if textField.text?.count == 0 || textField.text == nil {
            // Text가 존재하지 않을 때 버튼 비활성화
            
            addButton.isEnabled = false
            addButton.backgroundColor = .boardBlack10
            addButton.setTitleColor(.boardGray30, for: .normal)
        } else {
            // Text가 존재할 때 버튼 활성화
            
            addButton.isEnabled = true
            addButton.backgroundColor = .boardOrange
            addButton.setTitleColor(.boardWhite, for: .normal)
            
        }
        
    }
    
    func scrollViewTap() {
        //스크롤뷰 위에서 탭하면 키보드 내리기
        
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MyTapMethod))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(singleTapGestureRecognizer)
    }
    
    @objc func MyTapMethod(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    
}

// MARK: UICollectionViewDelegateFlowLayout

extension GameAddVC: UICollectionViewDelegateFlowLayout {
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

extension GameAddVC: UICollectionViewDataSource {
    // CollectionView 데이터 넣기
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == levelCollectionView {
            return level.count
        } else if collectionView == countCollectionView {
            return count.count
        } else {
            return keyword.count
        }
        
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
                } else {
                    showToast(message: "키워드는 3개까지 지정 가능해요", font: .neoBold(ofSize: 15), width: 200, bottomY: 50)
                }
            }
            
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == levelCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameTagCell.identifier, for: indexPath) as? GameTagCell else {
                return UICollectionViewCell()
            }
            
            cell.tagLabel.text = level[indexPath.row]
            return cell
            
        } else if collectionView == countCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameTagCell.identifier, for: indexPath) as? GameTagCell else {
                return UICollectionViewCell()
            }
            
            cell.tagLabel.text = count[indexPath.row]
            return cell
            
        } else {
            
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
    
}
// MARK: UITextFieldDelegate

extension GameAddVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 리턴 키 클릭 시
        
        textField.endEditing(true)
        return true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        // textField 클릭하면 무조건 키보드 올라오게
        textField.becomeFirstResponder()
    }
    
}
