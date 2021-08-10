//
//  ProfileVC.swift
//  boardpedia
//
//  Created by Hailey on 2021/08/10.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var nickTextField: UITextField!
    @IBOutlet weak var completeButton: UIButton!
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func completeButtonDidTap(_ sender: Any) {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        nickTextField.placeholder = "닉네임을 입력해주세요!"
        nickTextField.font = .neoMedium(ofSize: 16)
        nickTextField.setRounded(radius: 6)
        
        nickTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if textField.text?.count == 0 || textField.text == nil {
            // Text가 존재하지 않을 때 버튼 비활성화
            
            completeButton.isEnabled = false


        } else {
            
            completeButton.isEnabled = true

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
