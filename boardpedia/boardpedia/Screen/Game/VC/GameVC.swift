//
//  GameVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/28.
//

import UIKit

class GameVC: UIViewController {

    // MARK: Variable Part
    
    var tab1VC: GameManualVC! = nil
    var tab2VC: GameReviewVC! = nil
    var starPoint: Float = 4.8
    
    private var pageController: UIPageViewController!
    private var arrVC: [UIViewController] = []
    private var currentPage: Int!
    
    var gameDetail: GameDetailData?
    var heightConstraints: NSLayoutConstraint = NSLayoutConstraint()
    
    var reviewViewHeigth: CGFloat = 100
    var viewHeigth: CGFloat = 100
    
    // MARK: IBOutlet
    
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameTagCollectionView: UICollectionView!
    @IBOutlet weak var gameInfoLabel: UILabel!
    @IBOutlet weak var gameStarLabel: UILabel!
    
    @IBOutlet weak var saveImage: UIImageView!
    
    
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            // 동적 사이즈를 주기 위해 estimatedItemSize 를 사용했다. 대략적인 셀의 크기를 먼저 조정한 후에 셀이 나중에 AutoLayout 될 때, 셀의 크기가 변경된다면 그 값이 다시 UICollectionViewFlowLayout에 전달되어 최종 사이즈가 결정되게 된다.
        }
    }
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    
    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var lineFrame: NSLayoutConstraint!
    @IBOutlet weak var myView: UIView!
    
    // MARK: IBAction
    
    @IBAction func buttonDidTap(_ sender: UIButton) {
        
        if sender == self.firstButton {
            // 첫번째 버튼 클릭 시
            
            sender.tag = 1
            
//            self.myView.heightAnchor.constraint(equalToConstant: 2000).isActive = true
            
            
        
        } else if sender == self.secondButton {
            // 두번째 버튼 클릭 시
            
            sender.tag = 2
            
//            self.myView.heightAnchor.constraint(equalToConstant: reviewViewHeigth).isActive = true
        }
        
        pageController.setViewControllers([arrVC[sender.tag-1]], direction: UIPageViewController.NavigationDirection.reverse, animated: false, completion: {(Bool) -> Void in
        })
        
        resetTabBarForTag(tag: sender.tag-1)
    
        
    }
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setCollectionView()
        
    }
    
    override func didReceiveMemoryWarning() {
        // 메모리 경고 발생시
        super.didReceiveMemoryWarning()
    }
    

}


//MARK: Extension

extension GameVC {
    
    func setView() {
        
        currentPage = 0
        // 첫번째 버튼이 클릭 된 상태로 시작
        
        createPageViewController()
        viewLine.backgroundColor = .boardOrange
        
        self.firstButton.setButton(text: "게임 설명", color: .boardBlack, font: .neoSemiBold(ofSize: 16))
        self.secondButton.setButton(text: "후기", color: .boardGray50, font: .neoSemiBold(ofSize: 16))
    }
    
    func setCollectionView() {
        
        // Test Data (서버 연결 전)
        let item = GameDetailData(gameIdx: 73, name: "다빈치 코드", intro: "상대방의 숫자를 추리하여 맞춰보자!", imageURL: "https://www.koreaboardgames.com/upload/uploaded/prd/973341478169357.jpgg", playerNum: 2, maxPlayerNum: 4, duration: "15분", level: "하", tag: ["클래식", "머리쓰는", "카드","추리"], saved: 0, star: 3.5, objective: "여러분의 비밀코드는 숨기고, 상대방의 코드를 추리하세요. 하나씩 드러나는 상대방의 코드를 바탕으로 나머지 코드를 모두 맞춰보세요.", webURL: "https://www.koreaboardgames.com/upload/uploaded/prd/973341478169357.jpgg", method: "1.타일을 뒤집어서 잘 섞은 후, 각자 타일을 4개씩 가져오세요. \n2. 자기 차례가 되면 뒤집어진 타일 1개를 가져와 순서에 맞게 정리해서 놓으세요. 그리고 상대방의 타일 중 하나를 선택해 숫자를 맞혀주세요. \n3.상대방의 타일을 맞췄다면 계속 맞힐지 그만둘지를 결정하세요. \n4. 한 명만 남고 모든 타일이 공개되면 게임 끝!")
        
        gameDetail = item
        
        if let gameDetail = gameDetail {
            
            titleImageView.image = UIImage(named: "abaloneImg")
            gameNameLabel.setLabel(text: gameDetail.name, font: .neoSemiBold(ofSize: 22))
            gameInfoLabel.setLabel(text: gameDetail.intro, color: .boardGray50, font: .neoMedium(ofSize: 17))
            gameStarLabel.setLabel(text: "별점 \(gameDetail.star)점", font: .neoMedium(ofSize: 14))
            
            if gameDetail.saved == 0 {
                saveImage.image = UIImage(named: "icStorageUnselected")
            } else {
                saveImage.image = UIImage(named: "icStorageSelected")
            }
            
            viewHeigth = tab1VC.setData(name: gameDetail.name, objective: gameDetail.objective, time: 20, playerNum: gameDetail.playerNum, maxPlayerNum: gameDetail.maxPlayerNum, level: "하", method: gameDetail.method, tip: "어쩌구 저쩌구를 열심히 어쩌구 해보세요! 그럼 당신이 아발론 승리자!")
            
            self.myView.heightAnchor.constraint(equalToConstant: viewHeigth).isActive = true
            
        }
        
        
        gameTagCollectionView.delegate = self
        gameTagCollectionView.dataSource = self
        
        let layout = gameTagCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .vertical
    }
    
    //MARK: Set Page View Controller Func
    
    private func createPageViewController() {
        
        
        pageController = UIPageViewController.init(transitionStyle: UIPageViewController.TransitionStyle.scroll, navigationOrientation: UIPageViewController.NavigationOrientation.horizontal, options: nil)
        
        pageController.view.backgroundColor = UIColor.clear
        pageController.delegate = self
        pageController.dataSource = self
        
        for svScroll in pageController.view.subviews as! [UIScrollView] {
            svScroll.delegate = self
        }
        
        tab1VC = self.storyboard?.instantiateViewController(withIdentifier: "GameManualVC") as? GameManualVC
        tab2VC = self.storyboard?.instantiateViewController(withIdentifier: "GameReviewVC") as? GameReviewVC
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {

            self.pageController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.tab1VC.view.frame.height)
            self.myView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        arrVC = [tab1VC, tab2VC]
        
        pageController.setViewControllers([tab1VC], direction: UIPageViewController.NavigationDirection.forward, animated: false, completion: nil)
        
        self.addChild(pageController)
        self.myView.addSubview(pageController.view)
        pageController.didMove(toParent: self)
    }
    
    //MARK: Set View Line Frame
    
    private func selectedButton(btn: UIButton) {
        // 버튼 클릭 시 viewLine의 위치를 변경
        
        if btn.tag == 1 {
            
            lineFrame.constant = 0

        } else {
            
            lineFrame.constant = self.firstButton.frame.width
            
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    //MARK: Set Tabbar Style
    
    private func resetTabBarForTag(tag: Int) {
        
        
        var sender: UIButton!
        
        if(tag == 0) {
            sender = firstButton
            self.firstButton.setTitleColor(.boardBlack, for: .normal)
            self.secondButton.setTitleColor(.boardGray50, for: .normal)
            selectedButton(btn: sender)
        }
        else if(tag == 1) {
            sender = secondButton
            self.secondButton.setTitleColor(.boardBlack, for: .normal)
            self.firstButton.setTitleColor(.boardGray50, for: .normal)
            selectedButton(btn: sender)
        }
        
        currentPage = tag
        
    }
}

extension GameVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate {
    
    private func indexofviewController(viewCOntroller: UIViewController) -> Int {
        if(arrVC .contains(viewCOntroller)) {
            
            return arrVC.firstIndex(of: viewCOntroller)!
        }
        
        return -1
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = indexofviewController(viewCOntroller: viewController)
        
        if(index != -1) {
            index = index - 1
        }
        
        if(index < 0) {
            return nil
        }
        else {
            return arrVC[index]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = indexofviewController(viewCOntroller: viewController)
        
        if(index != -1) {
            index = index + 1
        }
        
        if(index >= arrVC.count) {
            return nil
        }
        else {
            return arrVC[index]
        }
    }
    
    func pageViewController(_ pageViewController1: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if(completed) {
            currentPage = arrVC.firstIndex(of: (pageViewController1.viewControllers?.last)!)
            resetTabBarForTag(tag: currentPage)
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension GameVC: UICollectionViewDelegateFlowLayout {
    // CollectionView 크기 잡기
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 한 아이템의 크기
        
        return CGSize(width: 78, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // collectionView와 View 간의 간격
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    
}

// MARK: UICollectionViewDataSource

extension GameVC: UICollectionViewDataSource {
    // CollectionView 데이터 넣기
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let data = gameDetail {
            return data.tag.count
        }
         return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameTagCell.identifier, for: indexPath) as? GameTagCell else {
            return UICollectionViewCell()
        }
        
        if let data = gameDetail {
            
            cell.tagLabel.text = data.tag[indexPath.row]
            
        }
        
        
        return cell
        
    }
    
}

