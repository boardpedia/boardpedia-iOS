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
    @IBOutlet weak var searchStateView: UIView!
    
    // MARK: IBOutlet
    
    var topKeyword: [TrendingGame] = []
    
    // MARK: IBAction
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setStateView()
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
    
    func setStateView() {
        
        // 키워드 검색 뷰
        
        guard let vc = self.storyboard?.instantiateViewController(identifier: "KeywordVC") as? KeywordVC else {
            return
        }
        vc.topKeywordData = topKeyword
        self.addChild(vc)

        self.searchStateView.addSubview(vc.view)
        vc.view.frame = self.searchStateView.bounds
        vc.willMove(toParent: self)
        vc.didMove(toParent: self)
        
        // 키워드 검색 결과 뷰
        
//        let vc = self.storyboard!.instantiateViewController(identifier: "SearchResultVC")
//        self.addChild(vc)
//
//        self.searchStateView.addSubview(vc.view)
//        vc.view.frame = self.searchStateView.bounds
//        vc.willMove(toParent: self)
//        vc.didMove(toParent: self)
        
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
