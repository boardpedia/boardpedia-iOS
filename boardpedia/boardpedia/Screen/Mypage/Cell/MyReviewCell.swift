//
//  MyReviewCell.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/13.
//

import UIKit

class MyReviewCell: UICollectionViewCell, UIGestureRecognizerDelegate {

    static let identifier = "MyReviewCell"
    var pan: UIPanGestureRecognizer!
    var deleteLabel2: UIButton!
    
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var firstKeywordLabel: UILabel!
    @IBOutlet weak var secondKeywordLabel: UILabel!
    @IBOutlet var starImageView: [UIImageView]!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit() {

        self.contentView.setRounded(radius: 6)
        self.contentView.backgroundColor = .boardWhite
        
        gameImageView.setRounded(radius: 6)
        gameNameLabel.setLabel(text: "", font: .neoMedium(ofSize: 16))
        firstKeywordLabel.setBorder(borderColor: .boardOrange, borderWidth: 1)
        secondKeywordLabel.setBorder(borderColor: .boardOrange, borderWidth: 1)
        firstKeywordLabel.setLabel(text: "", color: .boardOrange, font: .neoMedium(ofSize: 15))
        secondKeywordLabel.setLabel(text: "", color: .boardOrange, font: .neoMedium(ofSize: 15))

        deleteLabel2 = UIButton()
        deleteLabel2.setButton(text: "Delete", color: .white, font: .neoBold(ofSize: 16), backgroundColor: .boardOrange)
        self.insertSubview(deleteLabel2, belowSubview: self.contentView)

        pan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        pan.delegate = self
        self.addGestureRecognizer(pan)
      }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        if (pan.state == UIGestureRecognizer.State.changed) {
          let p: CGPoint = pan.translation(in: self)
          let width = self.contentView.frame.width
          let height = self.contentView.frame.height
          self.contentView.frame = CGRect(x: p.x,y: 0, width: width, height: height);
          self.deleteLabel2.frame = CGRect(x: p.x + width + deleteLabel2.frame.size.width, y: 0, width: 100, height: height)
        }

      }
    @objc func onPan(_ pan: UIPanGestureRecognizer) {
        if pan.state == UIGestureRecognizer.State.began {

        } else if pan.state == UIGestureRecognizer.State.changed {
          self.setNeedsLayout()
        } else {
          if abs(pan.velocity(in: self).x) > 500 {
            let collectionView: UICollectionView = self.superview as! UICollectionView
            let indexPath: IndexPath = collectionView.indexPathForItem(at: self.center)!
            collectionView.delegate?.collectionView!(collectionView, performAction: #selector(onPan(_:)), forItemAt: indexPath, withSender: nil)
          } else {
            UIView.animate(withDuration: 0.4, animations: {
              self.setNeedsLayout()
              self.layoutIfNeeded()
            })
          }
        }
      }
    
    // MARK: Data Set Function
    
    func configure(image: String, name: String, first: String, second: String, star: Float) {

        gameImageView.image = UIImage(named: image)
        gameNameLabel.text = name
        firstKeywordLabel.text = "  \(first)  "
        secondKeywordLabel.text = "  \(second)  "
        firstKeywordLabel.setRounded(radius: 11)
        secondKeywordLabel.setRounded(radius: 11)
        
        for i in Range(0...4) {
            if Float(i) < star {
                starImageView[i].image = UIImage(named: "icStar")
            } else {
                starImageView[i].image = UIImage(named: "icStarBlank")
            }
        }
        
    }

}
