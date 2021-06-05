//
//  NickVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/06/05.
//

import UIKit

class NickVC: UIViewController {

    // MARK: IBOutlet
    
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var nickTextField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    
    
    // MARK: IBAction
    
    
    // MARK: Life Cycle Part
    
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

// MARK: Extension

extension NickVC {
    
    // MARK: View Style Function
    
    func setView() {
        
        levelLabel.setLabel(text: "보드초보자", color: .boardOrange, font: .neoMedium(ofSize: 15))
        levelLabel.setRounded(radius: 12)
        levelLabel.setBorder(borderColor: .boardOrange, borderWidth: 1)
        levelLabel.backgroundColor = UIColor(red: 1.0, green: 119.0 / 255.0, blue: 72.0 / 255.0, alpha: 0.1)
        
        nickTextField.backgroundColor = .backGray
        nickTextField.placeholder = "닉네임을 입력해주세요!"
        nickTextField.font = .neoMedium(ofSize: 16)
        nickTextField.setRounded(radius: 6)
        
        nickTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
        
        startButton.setRounded(radius: 8)
        startButton.setButton(text: "보드피디아 시작하기", color: .boardWhite, font: .neoLight(ofSize: 18), backgroundColor: .boardGray20)
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if textField.text?.count == 0 || textField.text == nil {
            // Text가 존재하지 않을 때 버튼 비활성화
            
            startButton.isEnabled = false
            startButton.setButton(text: "보드피디아 시작하기", color: .boardWhite, font: .neoLight(ofSize: 18), backgroundColor: .boardGray20)


        } else {
            
            startButton.isEnabled = true
            startButton.setButton(text: "보드피디아 시작하기", color: .boardWhite, font: .neoBold(ofSize: 18 ), backgroundColor: .boardOrange)

        }
        
        if let count = textField.text?.count {
            if count > 4 {
                // 닉네임이 최대 4글자를 넘는다면?
                
                textField.deleteBackward()
                // 그 뒤에 글자들은 쳐져도 삭제된다
            }
        }
    }
}

// MARK: UITextFieldDelegate

extension NickVC: UITextFieldDelegate {
    
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
