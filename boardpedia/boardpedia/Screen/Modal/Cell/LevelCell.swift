//
//  LevelCell.swift
//  boardpedia
//
//  Created by 김민희 on 2021/08/07.
//

import UIKit

class LevelCell: UITableViewCell {

    static let identifier = "LevelCell"
    var clickIndexAction : ((Int) -> Void)? // closer 변수
    var cellIndex: IndexPath?
    
    @IBOutlet weak var levelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        self.contentView.backgroundColor = selected ? UIColor(red: 1.0, green: 119.0 / 255.0, blue: 72.0 / 255.0, alpha: 0.1) : UIColor.boardWhite
        self.levelLabel.textColor = selected ? UIColor.boardOrange : UIColor.black
        self.levelLabel.font = selected ? UIFont.neoSemiBold(ofSize: 16) : UIFont.neoMedium(ofSize: 16)
        
        guard let clickIndexAction = clickIndexAction else {
            return
        }
        
        if selected {
            // 선택했다면
            
            if let index = cellIndex?.row {
                clickIndexAction(index)
                // 인덱스 전달
            }
            
        }
        
        // 클릭한 인덱스 전달
        
        
    }


}
