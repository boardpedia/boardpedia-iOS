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
            transition.duration = 0.0
            transition.type = CATransitionType.fade
            self.navigationController?.view.layer.add(transition, forKey: nil)
            self.navigationController?.popViewController(animated: false)
            
        } else {
            
            self.navigationController?.popViewController(animated: true)
            NotificationCenter.default.removeObserver(self, name: .clickKeyword, object: nil)
        }
        
    }
    
    
    @IBAction func searchButtonDidTap(_ sender: Any) {
        
        searchTextField.endEditing(true)

        if (searchTextField.text != "") && (searchTextField.text != nil) && !searchView {
            
            guard let searchTab = self.storyboard?.instantiateViewController(identifier: "SearchVC") as? SearchVC else {
                return
            }
            
            saveRecentlyKeyword()
            
            let transition: CATransition = CATransition()
            transition.duration = 0.0
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
            self.searchTextField.text = nil
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
    
    @objc func clickKeyword(_ notification: Notification) {
        
        searchTextField.text = notification.object as? String
        
        guard let searchTab = self.storyboard?.instantiateViewController(identifier: "SearchVC") as? SearchVC else {
            return
        }
        
        saveRecentlyKeyword()
        
        let transition: CATransition = CATransition()
        transition.duration = 0.0
        transition.type = CATransitionType.fade
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(searchTab, animated: false)
        
        searchTab.searchView = true
        searchTab.searchText = searchTextField.text
        
        
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
            
            NotificationCenter.default.addObserver(self, selector: #selector(clickKeyword(_:)), name: .clickKeyword, object: nil)
            
        } else {
            
            // 키워드 검색 결과 뷰
            
            guard let vc = self.storyboard?.instantiateViewController(identifier: "SearchResultVC") as? SearchResultVC else {
                return
            }
            
            self.addChild(vc)
            vc.searchWord = searchTextField.text
            
            self.searchStateView.addSubview(vc.view)
            vc.view.frame = self.searchStateView.bounds
            vc.willMove(toParent: self)
            vc.didMove(toParent: self)
            
        }
        
    }
    
    // MARK: Save Recently Keyword
    
    func saveRecentlyKeyword() {
        
        if let recentlyKeyword = UserDefaults.standard.stringArray(forKey: "recentlyKeyword") {
            // 만약 이전 검색어가 있다면
            
            if recentlyKeyword.contains(searchTextField.text!) == false {
                // 이전 검색어가 아니라면
                
                var testArray = UserDefaults.standard.stringArray(forKey: "recentlyKeyword")
                testArray?.insert(searchTextField.text!, at: 0)
                // 맨 앞에 삽입
                
                if testArray!.count > 6 {
                    // 만약 최근 검색어가 6개를 넘는다면?
                    
                    UserDefaults.standard.setValue(Array(testArray![0..<6]), forKey: "recentlyKeyword")
                    // Array Slice를 이용해 자른 후 저장
                    
                } else {
                    
                    UserDefaults.standard.setValue(testArray, forKey: "recentlyKeyword")
                }
                
            } else {
                // 이전에 검색했던 검색어라면
                print(searchTextField.text!)
                
                var testArray = UserDefaults.standard.stringArray(forKey: "recentlyKeyword")
                
                if let firstIndex = testArray!.firstIndex(of: searchTextField.text!) {
                    
                    testArray!.remove(at: firstIndex)
                    testArray?.insert(searchTextField.text!, at: 0)
                    // 검색어를 삭제 후 맨 앞으로 다시 옮기기
                    
                    UserDefaults.standard.setValue(testArray, forKey: "recentlyKeyword")
                    
                }
                
                
            }
        } else {
            UserDefaults.standard.setValue([searchTextField.text!], forKey: "recentlyKeyword")
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
            
            saveRecentlyKeyword()
            
            let transition: CATransition = CATransition()
            transition.duration = 0.0
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
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        if searchView {
            let transition: CATransition = CATransition()
            transition.duration = 0.0
            transition.type = CATransitionType.fade
            self.navigationController?.view.layer.add(transition, forKey: nil)
            self.navigationController?.popViewController(animated: false)
        }
        
        return true
    }
    
}

extension Notification.Name {
    // Observer 이름 등록
    static let clickKeyword = Notification.Name("clickKeyword")
}

