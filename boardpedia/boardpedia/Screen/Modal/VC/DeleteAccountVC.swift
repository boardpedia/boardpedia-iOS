//
//  DeleteAccountVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/10/02.
//

import UIKit

class DeleteAccountVC: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var popButton: UIButton!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var deleteTextField: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    
    // MARK: - IBAction
    
    @IBAction func popButtonDidTap(_ sender: Any) { // X 버튼 클릭 시
        self.dismiss(animated: true)
    }
    @IBAction func deleteButtonDidTap(_ sender: Any) { // 탈퇴 버튼 클릭 시
        
        if NetworkState.isConnected() {

            if let jwt = UserDefaults.standard.string(forKey: "UserToken") {
                APIService.shared.deleteUser(jwt) { [self] result in
                    switch result {
                    
                    case .success(_):
                        self.dismiss(animated: true) {
                            self.showToast(message: "탈퇴완료:( 담에 봐요.", width: 250, bottomY: 50)
                        }
                        
                    case .failure(let error):
                        print(error)
                        
                    }
                }
            }
            
        } else {
            // 네트워크 확인 alert 띄워주기

            self.showNetworkModal()
            
        }
         
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 뷰 클릭 시 키보드 내리기
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.addKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.removeKeyboardNotifications()
    }

}

extension DeleteAccountVC {
    
    func setView() {
        popupView.layer.cornerRadius = 14
        popupView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        deleteTextField.setRounded(radius: 8)
        deleteTextField.delegate = self
        deleteTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        // deleteTextField가 수정될 때 마다 실행
        
        deleteButton.setButton(text: "탈퇴하기", color: .boardGray30, font: .neoBold(ofSize: 18), backgroundColor: .boardBlack10)
        deleteButton.isEnabled = false
        deleteButton.setRounded(radius: 8)
        
        popButton.setTitle("", for: .normal)
    }
    
    func addKeyboardNotifications(){
        // 키보드가 나타날 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification , object: nil)
        // 키보드가 사라질 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotifications(){
        // 키보드가 나타날 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        // 키보드가 사라질 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    
    @objc func keyboardWillShow(_ noti: NSNotification) {
//        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardRectangle = keyboardFrame.cgRectValue
//            let keyboardHeight = keyboardRectangle.height
//            self.view.frame.origin.y -= (keyboardHeight)
//        }
        guard let keyboardSize = (noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                   // if keyboard size is not available for some reason, dont do anything
                   return
                }
              
              // move the root view up by the distance of keyboard height
            self.view.frame.origin.y = 0 - keyboardSize.height
    }
    
    @objc func keyboardWillHide(_ noti: NSNotification) {
//        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardRectangle = keyboardFrame.cgRectValue
//            let keyboardHeight = keyboardRectangle.height
//            self.view.frame.origin.y += (keyboardHeight)
//        }
        self.view.frame.origin.y = 0
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if textField.text == "탈퇴" {
            deleteButton.isEnabled = true
            deleteButton.setButton(text: "탈퇴하기",
                                   color: .white,
                                   font: .neoBold(ofSize: 18),
                                   backgroundColor: .boardOrange)
        } else {
            deleteButton.isEnabled = false
            deleteButton.setButton(text: "탈퇴하기",
                                   color: .boardGray30,
                                   font: .neoBold(ofSize: 18),
                                   backgroundColor: .boardBlack10)
        }
        
    }


}

extension DeleteAccountVC: UITextFieldDelegate {
    
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
