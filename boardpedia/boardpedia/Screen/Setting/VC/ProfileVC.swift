//
//  ProfileVC.swift
//  boardpedia
//
//  Created by Hailey on 2021/08/10.
//

import UIKit

class ProfileVC: UIViewController {

    var nick: String?
    var giveNickAction : ((String) -> Void)?
    
    @IBOutlet weak var nickTextField: UITextField!
    @IBOutlet weak var completeButton: UIButton!
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func completeButtonDidTap(_ sender: Any) {
        
        if NetworkState.isConnected() {
            // 네트워크 연결 시
            
            if let token = UserDefaults.standard.string(forKey: "UserToken"),
               let nick = nick {
                
                APIService.shared.editUserName(token, nick) { [self] result in
                    switch result {
                    
                    case .success(_):
                        let storyboard = UIStoryboard(name: "Modal", bundle: nil)
                        guard let popUpVC =
                                storyboard.instantiateViewController(identifier: "PopUpVC") as? PopUpVC else {return}
                        
                        popUpVC.modalPresentationStyle = .overCurrentContext
                        popUpVC.modalTransitionStyle = .crossDissolve
                        self.present(popUpVC, animated: true, completion: nil)
                        popUpVC.titleLabel.text = "닉네임 정보가 변경되었어요!"
                        popUpVC.subLabel.text = "새로운 닉네임으로 보드피디아를 즐겨보세요."
                        
                        popUpVC.popButtonAction = {
                            // closure 호출
                            
                            self.navigationController?.popViewController(animated: true)
                            
                            guard let giveNickAction = self.giveNickAction else {
                                return
                            }
                            
                            giveNickAction(nick)
                        }
                        
                    case .failure(let error):
                        print(error)
                        
                    }
                    
                }
            }
            
        } else {
            
            // 네트워크 미연결 팝업
            
            self.showNetworkModal()
        }

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // 이 뷰에 들어오자 마자 바로 키보드 띄우고 cursor 포커스 주기
        self.nickTextField.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 뷰 클릭 시 키보드 내리기
        view.endEditing(true)
    }

}

extension ProfileVC {
    
    func setView() {
        
        nickTextField.backgroundColor = .backGray
        nickTextField.placeholder = "새로운 닉네임을 입력해주세요!"
        nickTextField.font = .neoMedium(ofSize: 16)
        nickTextField.setRounded(radius: 6)
        nickTextField.text = nick
        nickTextField.textAlignment = .center
        
        nickTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
        completeButton.isEnabled = false
        completeButton.setRounded(radius: 8)
        completeButton.setButton(text: "완료하기", color: .boardGray30, font: .neoBold(ofSize: 18), backgroundColor: .boardBlack10)
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if textField.text?.count == 0 || textField.text == nil || textField.text == nick {
            // 닉네임을 입력하지 않았거나, 변경되지 않았을 때 비활성화

            completeButton.isEnabled = false
            completeButton.backgroundColor = .boardBlack10
            completeButton.setTitleColor(.boardGray30, for: .normal)


        } else {

            completeButton.isEnabled = true
            completeButton.backgroundColor = .boardOrange
            completeButton.setTitleColor(.white, for: .normal)
        }

        if let count = textField.text?.count {
            if count > 4 {
                // 닉네임이 최대 4글자를 넘는다면?

                textField.deleteBackward()
                // 그 뒤에 글자들은 쳐져도 삭제된다
                showToast(message: "최대 글자수는 4글자예요", font: .neoBold(ofSize: 15), width: 188, bottomY: 50)
            }
        }
    }
}
