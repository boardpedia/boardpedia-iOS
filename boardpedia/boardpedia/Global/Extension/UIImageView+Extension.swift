//
//  UIImageView+Extension.swift
//  boardpedia
//
//  Created by 김민희 on 2021/06/16.
//

import Foundation
import Kingfisher


extension UIImageView {
    func setImage(from url: String) {
        self.kf.indicatorType = .activity
        let cache = ImageCache.default
        
        cache.retrieveImage(forKey: url) { result in
            switch result {
            case .success(let value):
                if value.image != nil {
                    self.image = value.image
                } else {
                    self.kf.setImage(with: URL(string: url))
                    
                }
                self.backgroundColor = .clear
            case .failure(let err):
                print(err.errorCode)
            }
        }
        
    }
}

