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
    
    private var pageController: UIPageViewController!
    private var arrVC: [UIViewController] = []
    private var currentPage: Int!
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    
    @IBOutlet weak var viewLine: UIView!
    
    @IBOutlet weak var lineFrame: NSLayoutConstraint!
    
    @IBOutlet weak var myView: UIView!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentPage = 0
        // 첫번째 버튼이 클릭 된 상태로 시작
        
        createPageViewController()
        viewLine.backgroundColor = .boardOrange
        
        self.firstButton.setButton(text: "게임 설명", color: .boardBlack, font: .neoSemiBold(ofSize: 16))
        self.secondButton.setButton(text: "후기", color: .boardGray50, font: .neoSemiBold(ofSize: 16))
    }
    
    override func didReceiveMemoryWarning() {
        // 메모리 경고 발생시
        super.didReceiveMemoryWarning()
    }
    

}


//MARK: Extension

extension GameVC {
    
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
        tab2VC = self.storyboard?.instantiateViewController(withIdentifier: "GameManualVC") as? GameManualVC
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {

            self.pageController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.tab1VC.view.frame.height)
            self.myView.translatesAutoresizingMaskIntoConstraints = false
            self.myView.heightAnchor.constraint(equalToConstant: self.tab1VC.view.frame.height).isActive = true
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
