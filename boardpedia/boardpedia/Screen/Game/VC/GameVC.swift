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
    var tab2VC: GameManualVC! = nil
    var starPoint: Float = 4.8
    
    private var pageController: UIPageViewController!
    private var arrVC: [UIViewController] = []
    private var currentPage: Int!
    
    var gameDetail: GameDetailData?
    var heightConstraints: NSLayoutConstraint = NSLayoutConstraint()
    // MARK: IBOutlet
    
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameTagCollectionView: UICollectionView!
    @IBOutlet weak var gameInfoLabel: UILabel!
    @IBOutlet weak var gameStarLabel: UILabel!
    
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
            
        
        } else if sender == self.secondButton {
            // 두번째 버튼 클릭 시
            
            sender.tag = 2
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
        let item = GameDetailData(gameIdx: 2, name: "다이아몬드 게임", intro: "내 말을 움직여 반대편의 우리집으로 먼저 옮기자!", imageURL: "https://www.koreaboardgames.com/upload/uploaded/prd/639261505700784.png", tag: ["유명한", "간단한", "클래식"], saved: 1, star: 3.5, objective: "도로, 마을과 도시, 교역로와 기사를 이용하여 가장 먼저 10점을 달성하세요. 상대방이 필요한 자원이 무엇인지 파악하고, 유리하게 거래에 이용해보세요!", webURL: "https://www.koreaboardgames.com/upload/uploaded/prd/639261505700784", method: "1. 맵을 구성하고 구성물을 나눠 가지세요.\n2. 플레이어 당 마을 2개와 도로 2개를 놓아 근거지를 정하세요.\n3. 주사위를 굴려 자원을 획득합니다.\n4. 자원을 교환하고 필요한 건물을 건설하여 영역을 확장해 나가보세요!")
        
        gameDetail = item
        
        if let gameDetail = gameDetail {
            
            titleImageView.image = UIImage(named: "abaloneImg")
            gameNameLabel.setLabel(text: gameDetail.name, font: .neoSemiBold(ofSize: 22))
            gameInfoLabel.setLabel(text: gameDetail.intro, color: .boardGray50, font: .neoMedium(ofSize: 17))
            gameStarLabel.setLabel(text: "별점 \(gameDetail.star)점", font: .neoMedium(ofSize: 14))
            
//            self.myView.heightAnchor.constraint(equalToConstant: self.tab1VC.view.frame.height).isActive = true
            
            tab1VC.setData(name: gameDetail.name, objective: gameDetail.objective, time: 20, headcount: "최대 2인", level: "하 (누구나 쉽게)", method: gameDetail.method)

            
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
        tab1VC.loadCompletion = { [weak self] height in
            guard let strongSelf = self else { return }
            strongSelf.heightConstraints.constant = height
            strongSelf.pageController.view.frame = CGRect(x: 0,
                                                          y: 0,
                                                          width: strongSelf.view.frame.size.width,
                                                          height: height)
            self?.view.layoutIfNeeded()
        }
        
        tab2VC = self.storyboard?.instantiateViewController(withIdentifier: "GameManualVC") as? GameManualVC
        
        self.myView.translatesAutoresizingMaskIntoConstraints = false
        heightConstraints = self.myView.heightAnchor.constraint(equalToConstant: 0)
        heightConstraints.isActive = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {

            
            
            
            
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
        }
        else if(tag == 1) {
            sender = secondButton
            self.secondButton.setTitleColor(.boardBlack, for: .normal)
            self.firstButton.setTitleColor(.boardGray50, for: .normal)
        }
        
        currentPage = tag
        selectedButton(btn: sender)
        
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

