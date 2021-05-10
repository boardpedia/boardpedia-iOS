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

    func lineSetting(kernValue: Double = 1.15, lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        // lineSetting: UILabel의 text가 lineSpacing 또는 letterSpacing 이 있을 때 사용
        
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        paragraphStyle.alignment = .center
        var attributedString = NSMutableAttributedString(string: labelText)
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length - 1))
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        // (Swift 4.2 and above) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
}
