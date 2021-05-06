//
//  UILabel+Extension.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/06.
//

import UIKit

extension UILabel {
    
    func setLabel(text: String, color: UIColor = .boardBlack, font: UIFont) {
        // setLabel : 내용, 폰트, 컬러까지 한번에 설정
        
        self.text = text
        self.font = font
        self.textColor = color
    }
    
    func setLabel(text: String, color: UIColor = .boardBlack, font: UIFont, letterSpacing: Double) {
        // setLabel : 위의 함수에서 letterSpacing 도 추가로 넣어야한다면 넣어서 사용할 수 있게 제작
        
        self.text = text
        var attributedString = NSMutableAttributedString(string: text)
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedString.length - 1))
        } else {
            attributedString = NSMutableAttributedString(string: text)
        }
        self.attributedText = attributedString
        self.font = font
        self.textColor = color
    }
}
