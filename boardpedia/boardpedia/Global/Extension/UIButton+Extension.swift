//
//  UIButton+Extension.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/07.
//

import UIKit

extension UIButton {
    
    func makeRounded(cornerRadius : CGFloat?) {
        // makeRounded : UIView 의 모서리가 둥근 정도를 설정
        
        if let cornerRadius_ = cornerRadius {
            self.layer.cornerRadius = cornerRadius_
        }  else {
            self.layer.cornerRadius = self.layer.frame.height / 2
        }
        
        self.layer.masksToBounds = true
    }
    
    func setButton(text: String, color: UIColor = .boardBlack, font: UIFont, backgroundColor: UIColor = .clear) {
        // setButton : 내용, 폰트, 컬러, background 컬러까지 한번에 설정
        
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = font
        self.tintColor = color
        self.backgroundColor = backgroundColor
    }
}
