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
    var gameIndex: Int?
    
    private var pageController: UIPageViewController!
    private var arrVC: [UIViewController] = []
    private var currentPage: Int!
    
    var gameDetailData: GameDetailData? {
        didSet {
            if gameDetailData?.saved == 0 {
                
                bookmarkImageView.image = UIImage(named: "icStorageUnselected")
                
            } else {
                bookmarkImageView.image = UIImage(named: "icStorageSelected")
            }
        }
    }
    var heightConstraints: NSLayoutConstraint = NSLayoutConstraint()
    
    var reviewViewHeigth: CGFloat = 100
    var viewHeigth: CGFloat = 100
    
    var impactFeedbackGenerator: UIImpactFeedbackGenerator?
    
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
    
    
    @IBOutlet weak var webButton: UIButton!
    @IBOutlet weak var webButtonImage: UIImageView!
    
    @IBOutlet weak var bookmarkImageView: UIImageView!
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    
    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var lineFrame: NSLayoutConstraint!
    @IBOutlet weak var myView: UIView!
    
    // MARK: IBAction
    
    @IBAction func webButtonDidTap(_ sender: Any) {
        // 웹 버튼 클릭 시
        
    }
    
    
    @IBAction func bookmarkButtonDidTap(_ sender: Any) {
        // 북마크 버튼 클릭 시
        
        self.impactFeedbackGenerator?.impactOccurred()
        
        if UserDefaults.standard.string(forKey: "UserSnsId") == "1234567" {
            // 비회원이라면 -> 로그인 하라는 창으로 이동
        
            let nextStoryboard = UIStoryboard(name: "Login", bundle: nil)
            guard let popUpVC = nextStoryboard.instantiateViewController(identifier: "LoginPopupVC") as? LoginPopupVC else { return }
            
            self.present(popUpVC, animated: true, completion: nil)
            // 로그인 유도 팝업 띄우기
            
            
        } else {
            // 회원 로그인을 했다면
            
            if let token = UserDefaults.standard.string(forKey: "UserToken") {
                // 토큰 존재 시
                
                if let data = gameDetailData,
                   let index = gameIndex {
                    
                    if data.saved == 0 {
                        // 미저장 -> 저장으로 변경
                        
                        APIService.shared.saveGame(token, index) { [self] result in
                            switch result {
                            
                            case .success(_):
                                
                                gameDetailData?.saved = 1
                                
                            case .failure(let error):
                                print(error)
                                
                            }
                            
                        }
                    } else {
                        // 저장 -> 미저장으로 변경
                        
                        APIService.shared.saveCancleGame(token, index) { [self] result in
                            switch result {
                            
                            case .success(_):
                                
                                gameDetailData?.saved = 0
                                
                            case .failure(let error):
                                print(error)
                                
                            }
                            
                        }
                        
                    }
                    
                }
            }
        }
    }
    
    
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
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
        
        self.impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    }
    
    func setCollectionView() {
        
        getGameDetailData()
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
        
        tab1VC.heightDelegate = self
        
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
    
    func getGameDetailData() {
        
        if let token = UserDefaults.standard.string(forKey: "UserToken"),
           let gameIdx = gameIndex {
            
            APIService.shared.getGameDetail(token, gameIdx) { [self] result in
                switch result {
                
                case .success(let data):
                    
                    gameDetailData = data
                    gameTagCollectionView.reloadData()
                    
                    if let data = gameDetailData {
                        
                        titleImageView.setImage(from: data.imageURL)
                        gameNameLabel.setLabel(text: data.name, font: .neoSemiBold(ofSize: 22))
                        gameInfoLabel.setLabel(text: data.intro, color: .boardGray50, font: .neoMedium(ofSize: 17))
                        gameStarLabel.setLabel(text: "별점 \(data.star)점", font: .neoMedium(ofSize: 14))
                        
                        if data.saved == 0 {
                            saveImage.image = UIImage(named: "icStorageUnselected")
                        } else {
                            saveImage.image = UIImage(named: "icStorageSelected")
                        }
                        
                        tab1VC.setData(name: data.name, objective: data.objective, time: data.duration, playerNum: data.playerNum, maxPlayerNum: data.maxPlayerNum, level: data.level, method: data.method, tip: data.tip, gameIdx: gameIdx)
                        
                        if data.webURL != "" {
                            // 웹 링크가 있다면?
                            
                            webButtonImage.image = UIImage(named: "icWebSiteSelected")
                            webButton.isEnabled = true
                            // 웹 버튼 활성화
                            
                        } else {
                            // 웹 링크가 없다면?
                            
                            webButtonImage.image = UIImage(named: "icWebSiteUnselected")
                            webButton.isEnabled = false
                            // 웹 버튼 비활성화
                            
                        }
                    }
                    
                case .failure(let error):
                    print(error)
                    
                }
                
            }

        }
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
        
        if let data = gameDetailData {
            return data.tag.count
        }
         return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameTagCell.identifier, for: indexPath) as? GameTagCell else {
            return UICollectionViewCell()
        }
        
        if let data = gameDetailData {
            
            cell.tagLabel.text = data.tag[indexPath.row]
            
        }
        
        
        return cell
        
    }
    
}

// MARK: ChangeHeightDelegate

extension GameVC: ChangeHeightDelegate {
    
    func GiveHeight(value: CGFloat) {
        
        self.myView.heightAnchor.constraint(equalToConstant: value).isActive = true
        // 높이 변경
    }
}
