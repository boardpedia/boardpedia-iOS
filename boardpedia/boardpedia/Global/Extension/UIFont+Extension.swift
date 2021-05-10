//
//  UIFont+Extension.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/06.
//

import UIKit

struct AppFontName {
    
    static let regular = "AppleSDGothicNeo-Regular"
    static let bold = "AppleSDGothicNeo-Bold"
    static let light = "AppleSDGothicNeo-Light"
    static let medium = "AppleSDGothicNeo-Medium"
    static let semiBold = "AppleSDGothicNeo-SemiBold"
    static let thin = "AppleSDGothicNeo-Thin"
    static let ultraLigth = "AppleSDGothicNeo-UltraLight"

}

extension UIFont {

    class func neoRegular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.regular, size: size)!
    }

    class func neoBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.bold, size: size)!
    }

    class func neoLight(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.light, size: size)!
    }
    
    class func neoMedium(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.medium, size: size)!
    }
    
    class func neoSemiBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.semiBold, size: size)!
    }
    
    class func neoThin(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.thin, size: size)!
    }
    
    class func neoUltraLight(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.ultraLigth, size: size)!
    }

}
