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
    var searchView: Bool = false
    var searchText: String?
    
    // MARK: IBAction
    
    @IBAction func backButtonDidTap(_ sender: UIButton) {
        
        if searchView {
            
            let transition: CATransition = CATransition()
            transition.duration = 0.3
            transition.type = CATransitionType.fade
            self.navigationController?.view.layer.add(transition, forKey: nil)
            self.navigationController?.popViewController(animated: false)
            
        } else {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    @IBAction func searchButtonDidTap(_ sender: Any) {
        
        searchTextField.endEditing(true)

        if (searchTextField.text != "") && (searchTextField.text != nil) && !searchView {
            
            guard let searchTab = self.storyboard?.instantiateViewController(identifier: "SearchVC") as? SearchVC else {
                return
            }
            
            let transition: CATransition = CATransition()
            transition.duration = 0.3
            transition.type = CATransitionType.fade
            self.navigationController?.view.layer.add(transition, forKey: nil)
            self.navigationController?.pushViewController(searchTab, animated: false)
            
            searchTab.searchView = true
            searchTab.searchText = searchTextField.text
            
        }
        
    }
    
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        
        // 이 뷰에 들어오자 마자 바로 키보드 띄우고 cursor 포커스 주기
        
        if !searchView {
            self.searchTextField.becomeFirstResponder()
        }
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
        
        if let text = searchText {
            searchTextField.text = text
        }
    
    }
    
    func setStateView() {
        
        // 키워드 검색 뷰
        
        if !searchView {
            
            guard let vc = self.storyboard?.instantiateViewController(identifier: "KeywordVC") as? KeywordVC else {
                return
            }
            vc.topKeywordData = topKeyword
            self.addChild(vc)

            self.searchStateView.addSubview(vc.view)
            vc.view.frame = self.searchStateView.bounds
            vc.willMove(toParent: self)
            vc.didMove(toParent: self)
            
        } else {
            
            // 키워드 검색 결과 뷰
            
            let vc = self.storyboard!.instantiateViewController(identifier: "SearchResultVC")
            self.addChild(vc)
            
            self.searchStateView.addSubview(vc.view)
            vc.view.frame = self.searchStateView.bounds
            vc.willMove(toParent: self)
            vc.didMove(toParent: self)
            
        }
        
    }
}

// MARK: UITextFieldDelegate

extension SearchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)

        if (textField.text != "") && (textField.text != nil) && !searchView {
            
            guard let searchTab = self.storyboard?.instantiateViewController(identifier: "SearchVC") as? SearchVC else {
                return true
            }
            
            let transition: CATransition = CATransition()
            transition.duration = 0.3
            transition.type = CATransitionType.fade
            self.navigationController?.view.layer.add(transition, forKey: nil)
            self.navigationController?.pushViewController(searchTab, animated: false)
            
            searchTab.searchView = true
            searchTab.searchText = searchTextField.text
            
        }

        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchTextField.becomeFirstResponder()
    }
    
}
