//
//  UITextField+Extension.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/11.
//

import UIKit

extension UITextField {
    
    func addLeftPadding() {
        // addLeftPadding : 왼쪽에 패딩 설정
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
