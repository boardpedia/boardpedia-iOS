//
//  ExVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/13.
//

import UIKit

class SwipeListVC: UIViewController {
    
    // MARK: Variable Part
    
    var tab1VC: MySaveListVC! = nil
    var tab2VC: MyReviewListVC! = nil
    
    private var pageController: UIPageViewController!
    private var arrVC:[UIViewController] = []
    private var currentPage: Int!
    
    // MARK: IBOutlet
    
    @IBOutlet weak var tabBarView: UIView!
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    
    @IBOutlet weak var viewLine: UIView!
    
    @IBOutlet weak var lineFrame: NSLayoutConstraint!
    
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
        
        currentPage = 0
        // 첫번째 버튼이 클릭 된 상태로 시작
        
        createPageViewController()
        viewLine.backgroundColor = .boardOrange
        
        self.firstButton.setButton(text: "저장 목록", color: .boardBlack, font: .neoSemiBold(ofSize: 16))
        self.secondButton.setButton(text: "후기 목록", color: .boardGray50, font: .neoSemiBold(ofSize: 16))
        
    }
    
    override func didReceiveMemoryWarning() {
        // 메모리 경고 발생시
        super.didReceiveMemoryWarning()
    }
    
    
}

//MARK: Extension

extension SwipeListVC {
    
    //MARK: Set Page View Controller Func
    
    private func createPageViewController() {
        
        
        pageController = UIPageViewController.init(transitionStyle: UIPageViewController.TransitionStyle.scroll, navigationOrientation: UIPageViewController.NavigationOrientation.horizontal, options: nil)
        
        pageController.view.backgroundColor = UIColor.clear
        pageController.delegate = self
        pageController.dataSource = self
        
        for svScroll in pageController.view.subviews as! [UIScrollView] {
            svScroll.delegate = self
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            
            self.pageController.view.frame = CGRect(x: 0, y: self.viewLine.frame.maxY + self.view.safeAreaInsets.top, width: self.view.frame.size.width, height: self.view.frame.size.height-(self.viewLine.frame.maxY + self.view.safeAreaInsets.top))
        }
        
        tab1VC = self.storyboard?.instantiateViewController(withIdentifier: "MySaveListVC") as? MySaveListVC
        tab2VC = self.storyboard?.instantiateViewController(withIdentifier: "MyReviewListVC") as? MyReviewListVC
        
        
        arrVC = [tab1VC, tab2VC]
        
        pageController.setViewControllers([tab1VC], direction: UIPageViewController.NavigationDirection.forward, animated: false, completion: nil)
        
        self.addChild(pageController)
        self.view.addSubview(pageController.view)
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

extension SwipeListVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate {
    
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
