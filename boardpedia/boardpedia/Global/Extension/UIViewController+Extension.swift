//
//  UIViewController+Extension.swift
//  boardpedia
//
//  Created by 김민희 on 2021/07/25.
//

import UIKit


extension UIViewController {
    
    // MARK: Toast Alert Extension
    
    func showToast(message : String, width: Int, bottomY: Int) {
        let guide = view.safeAreaInsets.bottom
        let y = self.view.frame.size.height-guide
        
        let toastLabel = UILabel(
            frame: CGRect( x: self.view.frame.size.width/2 - CGFloat(width)/2,
                           y: y-CGFloat(bottomY),
                           width: CGFloat(width),
                           height: 39
            )
        )
        
        toastLabel.backgroundColor = UIColor(red: 140.0 / 255.0, green: 140.0 / 255.0, blue: 140.0 / 255.0, alpha: 1.0)
        toastLabel.textColor = UIColor.white
        toastLabel.font = .neoSemiBold(ofSize: 16)
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
    
    
    func showNetworkModal() {
        
        let storyboard = UIStoryboard(name: "Modal", bundle: nil)
        guard let popUpVC =
                storyboard.instantiateViewController(identifier: "NetworkErrorVC") as? NetworkErrorVC else {return}
        
        popUpVC.modalPresentationStyle = .overCurrentContext
        popUpVC.modalTransitionStyle = .crossDissolve
        self.present(popUpVC, animated: true, completion: nil)
        
    }
}

