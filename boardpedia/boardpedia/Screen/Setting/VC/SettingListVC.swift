//
//  SettingListVC.swift
//  boardpedia
//
//  Created by Hailey on 2021/08/10.
//

import UIKit
import MessageUI

class SettingListVC: UIViewController {

    
    var section1 = ["프로필 설정", "문의하기", "개인정보처리방침"]
    var section2 = ["버전 1.0","로그아웃","탈퇴하기"]
    var nick: String?
    var giveNickAction : ((String) -> Void)?
    
    
    @IBOutlet weak var subView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
    }
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    lazy var tableView: UITableView = {
        
        let displayWidth: CGFloat = self.subView.frame.width
        let displayHeight: CGFloat = self.subView.frame.height
        let tableView: UITableView = UITableView(frame: CGRect(x: 0, y: self.subView.frame.minY+10, width: displayWidth, height: displayHeight))
        
        // Set the DataSource.
        tableView.dataSource = self
        // Set Delegate.
        tableView.delegate = self
        
        let nibName = UINib(nibName: "SettingCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "SettingCell")
        
        tableView.separatorStyle = .none
        
        return tableView
        
    }()
    
    func showSendMailErrorAlert() {
        
        let sendMailErrorAlert = UIAlertController(title: "메일 전송 실패", message: "아이폰 - Mail 설정을 확인해주세요.\n(문의 이메일 주소: boardpediaofficial@gmail.com)", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default)
        
        sendMailErrorAlert.addAction(confirmAction)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }

}

extension SettingListVC: UITableViewDelegate {
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
        {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 10))
            if (section == 1) {
                headerView.backgroundColor = UIColor.backGray
            }
            return headerView
        }
    
}

extension SettingListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingCell

        if indexPath.section == 0 {
            cell.titleLabel.text = section1[indexPath.row]
            
        } else if indexPath.section == 1 {
            cell.titleLabel?.text = "\(section2[indexPath.row])"
            
        } else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                // 프로필 설정
                
                if UserDefaults.standard.string(forKey: "UserSnsId") != "1234567" {
                    // 비회원이 아니라면?
                    
                    guard let profileVC = self.storyboard?.instantiateViewController(identifier: "ProfileVC") as? ProfileVC else {
                        return
                    }
                    
                    profileVC.hidesBottomBarWhenPushed = true
                    profileVC.giveNickAction = {
                        
                        text in
                        
                        self.nick = text
                        
                        guard let giveNickAction = self.giveNickAction else {
                            return
                        }
                        
                        giveNickAction(text)
                    }
                    
                    self.navigationController?.pushViewController(profileVC, animated: true)
                    
                    profileVC.nick = nick
                } else {
                    // 비회원이라면
                    
                    let nextStoryboard = UIStoryboard(name: "Login", bundle: nil)
                    guard let popUpVC = nextStoryboard.instantiateViewController(identifier: "LoginPopupVC") as? LoginPopupVC else { return }
                    
                    self.present(popUpVC, animated: true, completion: nil)
                    // 로그인 유도 팝업 띄우기
                }
                
            } else if indexPath.row == 1 {
                // 문의하기 클릭
                
                if MFMailComposeViewController.canSendMail() {
                    // 메일 보내기가 가능한지 확인
                    
                    let compseVC = MFMailComposeViewController()
                    compseVC.mailComposeDelegate = self
                    
                    compseVC.setToRecipients(["boardpediaofficial@gmail.com"])
                    compseVC.setSubject("‘보드피디아’ 1:1 문의하기")
                    compseVC.setMessageBody("문의 내용:", isHTML: false)
                    
                    self.present(compseVC, animated: true, completion: nil)
                    
                }
                else {
                    // 불가능 시 alter으로 보여주기
                    
                    self.showSendMailErrorAlert()
                }
            }
        }
    }
    
    
    
}
extension SettingListVC: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true, completion: nil)
        }
}
