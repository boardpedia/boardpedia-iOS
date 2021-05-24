//
//  ThemeVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/24.
//

import UIKit

class ThemeVC: UIViewController {

    @IBOutlet weak var themeListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        themeListCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    

}

extension ThemeVC: UICollectionViewDelegateFlowLayout {
    
}

extension ThemeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrandingGameCell.identifier, for: indexPath) as? TrandingGameCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            
            let headerview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ThemeCollectionReusableView", for: indexPath) as! ThemeCollectionReusableView
//        headerview.constraints.hei
        headerview.setTheme(info: "✋은 👀보다 빠르다", title: "내가 이 구역 최고 브레인!")
            return headerview
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

        // Get the view for the first header
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)

        // Use this view to calculate the optimal size based on the collection view's width
        return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width, height: 285/375 * collectionView.frame.width),
                                                  withHorizontalFittingPriority: .required, // Width is fixed
                                                  verticalFittingPriority: .fittingSizeLevel) // Height can be as large as needed
    }
    
    
}
