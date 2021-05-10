//
//  UIColor+Extension.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/06.
//

import UIKit

extension UIColor {
    // 보드피디아 전용 컬러칩 설정
    
    @nonobjc class var boardGray: UIColor {
        return UIColor(red: 238.0 / 255.0, green: 238.0 / 255.0, blue: 239.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var boardWhite: UIColor {
        return UIColor(white: 1.0, alpha: 1.0)
    }
    
    @nonobjc class var boardWhite70: UIColor {
        return UIColor(white: 1.0, alpha: 0.7)
    }
    
    @nonobjc class var boardBlack: UIColor {
        return UIColor(white: 0.0, alpha: 1.0)
    }
    
    @nonobjc class var boardOrange: UIColor {
        return UIColor(red: 1.0, green: 119.0 / 255.0, blue: 72.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var boardGray40: UIColor {
        return UIColor(white: 0.0, alpha: 0.4)
    }
    
    @nonobjc class var boardGray20: UIColor {
        return UIColor(white: 0.0, alpha: 0.2)
    }
    
    @nonobjc class var boardGray30: UIColor {
        return UIColor(white: 0.0, alpha: 0.3)
    }
    
    @nonobjc class var boardGray50: UIColor {
        return UIColor(white: 0.0, alpha: 0.5)
    }
    
    @nonobjc class var backGray: UIColor {
        return UIColor(red: 247.0 / 255.0, green: 248.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)
    }
}
