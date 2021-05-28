//
//  GameCollectVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/27.
//

import UIKit

class GameCollectVC: UIViewController {

    @IBOutlet weak var gameCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerXib()

        // Do any additional setup after loading the view.
    }
    
    private func registerXib() {

        let nibName = UINib(nibName: "GameCollectionCell", bundle: nil)

        gameCollectionView.register(nibName, forCellWithReuseIdentifier: "GameCollectionCell")

    }

}
