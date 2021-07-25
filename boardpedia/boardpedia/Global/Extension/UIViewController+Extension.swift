//
//  UIViewController+Extension.swift
//  boardpedia
//
//  Created by 김민희 on 2021/07/25.
//

import UIKit


extension UIViewController {
    
    // MARK: Toast Alert Extension
    
    func showToast(message : String, font: UIFont, width: Int, bottomY: Int) {
        let guide = view.safeAreaInsets.bottom
        let y = self.view.frame.size.height-guide
        
        let toastLabel = UILabel(
            frame: CGRect( x: self.view.frame.size.width/2 - CGFloat(width)/2,
                           y: y-CGFloat(bottomY),
                           width: CGFloat(width),
                           height: 40
            )
        )
        
        toastLabel.backgroundColor = UIColor.darkGray
        toastLabel.textColor = UIColor.boardOrange
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 6
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 1.2, delay: 0.7, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
