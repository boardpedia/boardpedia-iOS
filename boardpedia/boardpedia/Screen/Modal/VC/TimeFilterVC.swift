//
//  TimeFilterVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/08/07.
//

import UIKit

class TimeFilterVC: UIViewController {
    
    // MARK: Variable Part
    
    var date: Int = 10 {
        didSet {
            timeLabel.text = "\(date)분"
        }
        // 10분 단위로 10분 ~ 180분 까지
    }

    // MARK: IBOutlet
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    // MARK: IBAction
    
    @IBAction func minusButtonDidTap(_ sender: Any) {
        if date > 10 {
            date -= 10
        }
        
    }
    
    @IBAction func plusButtonDidTap(_ sender: Any) {
        if date < 180 {
            date += 10
        }
    }
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        
    }
    
}

// MARK: Extension

extension TimeFilterVC {
    
    func setView() {
        
        timeLabel.setLabel(text: "\(date)분", font: .neoMedium(ofSize: 16))
        
        minusButton.setRounded(radius: nil)
        plusButton.setRounded(radius: nil)
        
        minusButton.setBorder(borderColor: .boardGray50, borderWidth: 1)
        plusButton.setBorder(borderColor: .boardGray50, borderWidth: 1)
        
        popupView.layer.cornerRadius = 14
        popupView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
    }
}
