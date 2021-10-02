//
//  DeleteAccountVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/10/02.
//

import UIKit

class DeleteAccountVC: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var deleteTextField: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    
    // MARK: - IBAction
    
    @IBAction func deleteButtonDidTap(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }

}

extension DeleteAccountVC {
    func setView() {
        popupView.layer.cornerRadius = 14
        popupView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        deleteTextField.setRounded(radius: 8)
        deleteTextField.delegate = self
        
        deleteButton.setButton(text: "탈퇴하기", color: .boardGray30, font: .neoBold(ofSize: 18), backgroundColor: .boardBlack10)
        deleteButton.isEnabled = false
    }
}

extension DeleteAccountVC: UITextFieldDelegate {
    
    
}
