//
//  TimeFilterVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/08/07.
//

import UIKit

class TimeFilterVC: UIViewController {
    
    // MARK: Variable Part
    
    var date: Int = 0 {
        didSet {
            timeLabel.text = "\(date)분"
        }
        // 10분 단위로 0분 ~ 180분 까지
    }
    var timeFilterAction : ((Int) -> Void)? // closer 변수

    // MARK: IBOutlet
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    // MARK: IBAction
    
    @IBAction func minusButtonDidTap(_ sender: Any) {
        if date > 0 {
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 뷰 클릭 시 뷰 내리기

        self.dismiss(animated: true)
        
        guard let timeFilterAction = timeFilterAction else {
            return
        }
        
        timeFilterAction(date)
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
