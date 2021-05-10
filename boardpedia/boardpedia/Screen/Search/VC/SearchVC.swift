//
//  SearchVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/10.
//

import UIKit

class SearchVC: UIViewController {

    // MARK: Variable Part
    
    @IBOutlet weak var searchHeaderView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    
    // MARK: IBOutlet
    
    // MARK: IBAction
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()

//        let vc = self.storyboard!.instantiateViewController(identifier: "subViewController")
//        self.addChild(vc)
//        vc.view.frame = presentView.frame
//        self.presentView.addSubview(vc.view)
//        vc.didMove(toParent: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 뷰 클릭 시 키보드 내리기
        view.endEditing(true)
    }

}

// MARK: Extension

extension SearchVC {
    
    // MARK: View Style Function
    
    func setView() {
        
        searchHeaderView.setRounded(radius: 6)
        
        searchTextField.addLeftPadding()
        searchTextField.placeholder = "원하는 보드게임을 찾아보세요!"
        searchTextField.font = .neoMedium(ofSize: 17)
        searchTextField.delegate = self
    
    }
}

// MARK: UITextFieldDelegate

extension SearchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchTextField.becomeFirstResponder()
    }
    
}
