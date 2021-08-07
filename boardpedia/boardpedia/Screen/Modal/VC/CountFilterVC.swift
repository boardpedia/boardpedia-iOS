//
//  CountFilterVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/08/08.
//

import UIKit

class CountFilterVC: UIViewController {
    // MARK: Variable Part
    
    var count: Int = 0 {
        didSet {
            timeLabel.text = "\(count)명"
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
        if count > 0 {
            count -= 1
        }
        
    }
    
    @IBAction func plusButtonDidTap(_ sender: Any) {
        if count < 10 {
            count += 1
        }
    }
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 뷰 클릭 시 뷰 내리기
        
        self.dismiss(animated: true)
    }
    
}

// MARK: Extension

extension CountFilterVC {
    
    func setView() {
        
        timeLabel.setLabel(text: "\(count)명", font: .neoMedium(ofSize: 16))
        
        minusButton.setRounded(radius: nil)
        plusButton.setRounded(radius: nil)
        
        minusButton.setBorder(borderColor: .boardGray50, borderWidth: 1)
        plusButton.setBorder(borderColor: .boardGray50, borderWidth: 1)
        
        popupView.layer.cornerRadius = 14
        popupView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
    }
}
