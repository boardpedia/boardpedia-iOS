//
//  ThemeVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/24.
//

import UIKit

class ThemeVC: UIViewController {
    
    // MARK: Variable Part
    
    var themeDetailData: ThemeDetailData?
    var themeIdx: Int?
    
    // MARK: IBOutlet
    
    @IBOutlet weak var themeListCollectionView: UICollectionView!
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setResultCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if NetworkState.isConnected() {
            if let token = UserDefaults.standard.string(forKey: "UserToken"),
               let index = themeIdx {
                // 테마 받아오는 서버 연결
                getThemeGame(token: token, index: index)
            }
        } else {
            self.showNetworkModal()
        }
        
    }
    
}

// MARK: Extension

extension ThemeVC {
    
    // MARK: Result Data Style Function
    
    func setResultCollectionView() {
        
        themeListCollectionView.delegate = self
        themeListCollectionView.dataSource = self
        themeListCollectionView.backgroundColor = .boardGray
    }
    
    func getThemeGame(token: String, index: Int) {
        
        APIService.shared.todayThemeDetail(token, index) { [self] result in
            switch result {
            
            case .success(let data):
                themeDetailData = data
                themeListCollectionView.reloadData()
                // 데이터 화면에 뿌려주기
                
            case .failure(let error):
                print(error)
                
            }
            
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension ThemeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 한 아이템의 크기
        
        let itemWidth = self.view.frame.width - 32
        return CGSize(width: itemWidth, height: 120/343 * itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // 아이템간의 간격
        
        return 10
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // collectionView와 View 간의 간격
        
        return UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        
    }
    
}

// MARK: UICollectionViewDataSource

extension ThemeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let data = themeDetailData?.themeGame {
            return data.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard.init(name: "Game", bundle: nil)
        guard let gameTab = storyboard.instantiateViewController(identifier: "GameVC") as? GameVC else {
            return
        }
        
        self.navigationController?.pushViewController(gameTab, animated: true)
        // 클릭한 게임 상세보기 뷰로 이동
        
        gameTab.gameIndex = themeDetailData?.themeGame[indexPath.row].gameIdx
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeGameListCell.identifier, for: indexPath) as? ThemeGameListCell else {
            return UICollectionViewCell()
        }
        
        if let data = themeDetailData?.themeGame[indexPath.row] {
            cell.configure(image: data.imageURL, name: data.name, info: data.intro, star: data.star, save: data.saveCount)
            
            if data.saved == 0 {
                // 북마크 상태가 미선택된 상태라면
                
                cell.bookmarkButton.setImage(UIImage(named: "icStorageUnselected"), for: .normal)
            } else {
                // 북마크 상태가 선택된 상태라면
                cell.bookmarkButton.setImage(UIImage(named: "icStorageSelected"), for: .normal)
            }
        }
        
        cell.cellDelegate = self
        cell.cellIndex = indexPath
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // collectionView 헤더 설정
        
        let headerview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ThemeCollectionReusableView", for: indexPath) as! ThemeCollectionReusableView
        
        if let data = themeDetailData?.themes[0] {
            headerview.setTheme(info: data.detail, title: data.name, back: data.imageURL)
            headerview.setTag(tag: data.tag)
        }
        
        headerview.backButtonAction = {
            // closure 호출
            
            self.navigationController?.popViewController(animated: true)
        }
        
        return headerview
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // collectionView header 동적 높이 설정
        
        return CGSize(width: collectionView.frame.width, height: 285/375 * collectionView.frame.width)
    }
    
}


extension ThemeVC: BookmarkCellDelegate {
    func BookmarkCellGiveIndex(_ cell: UICollectionViewCell, didClickedIndex value: Int) {
        
        
        if UserDefaults.standard.string(forKey: "UserSnsId") == "1234567" {
            // 비회원이라면 -> 로그인 하라는 창으로 이동
        
            let nextStoryboard = UIStoryboard(name: "Login", bundle: nil)
            guard let popUpVC = nextStoryboard.instantiateViewController(identifier: "LoginPopupVC") as? LoginPopupVC else { return }
            
            self.present(popUpVC, animated: true, completion: nil)
            // 로그인 유도 팝업 띄우기
            
            
        } else {
            // 회원 로그인을 했다면
            
            if NetworkState.isConnected() {
                if let token = UserDefaults.standard.string(forKey: "UserToken") {
                    // 토큰 존재 시
                    if let data = themeDetailData?.themeGame[value],
                       let index = themeIdx {
                        
                        if data.saved == 0 {
                            // 미저장 -> 저장으로 변경
                            
                            APIService.shared.saveGame(token, data.gameIdx) { [self] result in
                                switch result {
                                
                                case .success(_):
                                    
                                    getThemeGame(token: token, index: index)
                                    showToast(message: "북마크 완료 ⭐️", width: 124, bottomY: 64)
                                    
                                case .failure(let error):
                                    print(error)
                                    
                                }
                                
                            }
                        } else {
                            // 저장 -> 미저장으로 변경
                            
                            APIService.shared.saveCancleGame(token, data.gameIdx) { [self] result in
                                switch result {
                                
                                case .success(_):
                                    
                                    getThemeGame(token: token, index: index)
                                    showToast(message: "저장 목록에서 삭제되었어요", width: 205, bottomY: 64)
                                    
                                case .failure(let error):
                                    print(error)
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            } else {
                self.showNetworkModal()
            }
            
            
        }
    }
}
