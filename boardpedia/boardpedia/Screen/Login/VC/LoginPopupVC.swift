//
//  LoginPopupVC.swift
//  boardpedia
//
//  Created by 김민희 on 2021/06/05.
//

import UIKit
import AuthenticationServices
import KakaoSDKUser

class LoginPopupVC: UIViewController, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    @IBAction func cancleButtonDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func kakaoLoginButtonDidTap(_ sender: Any) {
        
        if (UserApi.isKakaoTalkLoginAvailable()) { // 카카오톡이 깔려있는지
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    // 로그인 하다가 에러 발생 시
                    self.showToast(message: "오류 발생🚨 다시 시도해주세요.", width: 300, bottomY: 50)
                }
                else {
                    // 로그인 성공 시
                    self.kakaoLoginSuccess()

                }
            }
        } else { // 카카오톡이 안깔려 있을 때
            self.showToast(message: "카카오톡 미설치 유저예요:(", width: 250, bottomY: 50)
        }
        
    }
    var tokenData: TokenData?
    var loginDoneAction: (() -> Void)? // 로그인 시 현재 페이지 reload하기 위한 closure
    
    @IBOutlet weak var appleView: UIView!
    @IBOutlet weak var popupView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popupView.setRounded(radius: 10)
        let appleLoginButton = ASAuthorizationAppleIDButton(type: .continue, style: .white)
        
        appleLoginButton.layer.borderWidth = 1
        appleLoginButton.layer.borderColor = UIColor.black.cgColor
        appleLoginButton.setRounded(radius: 8)

        appleLoginButton.translatesAutoresizingMaskIntoConstraints = false
        appleLoginButton.widthAnchor.constraint(equalToConstant: self.view.frame.width-32).isActive = true
        appleLoginButton.heightAnchor.constraint(equalToConstant: appleView.frame.height).isActive = true
        
        appleLoginButton.addTarget(self, action: #selector(appleLoginButtonDidTap), for: .touchUpInside)
        appleView.addSubview(appleLoginButton)
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 뒷 배경 클릭 시 Event
        
        super.touchesBegan(touches, with: event)
        if let touch = touches.first , touch.view == self.view {
            
            self.dismiss(animated: true, completion: nil)
            
            
        }
    }
    
    @objc func appleLoginButtonDidTap() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
           let request = appleIDProvider.createRequest()
           request.requestedScopes = [.fullName, .email]
               
           let authorizationController = ASAuthorizationController(authorizationRequests: [request])
           authorizationController.delegate = self
           authorizationController.presentationContextProvider = self
           authorizationController.performRequests()
    }
    
    // Apple ID 연동 성공 시
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        // Apple ID
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
                
            // 계정 정보 가져오기
            let userIdentifier = appleIDCredential.user
                //000684.f8590ae737d74fa5ad4a5120b0432991.1718
            print("User ID : \(userIdentifier)")
            
            if NetworkState.isConnected() {
                APIService.shared.login(userIdentifier, "apple") { [self] result in
                    switch result {
                    
                    case .success(let data):
                        
                        tokenData = data
                        
                        UserDefaults.standard.setValue(tokenData?.accessToken, forKey: "UserToken")
                        // 토큰 저장
                        UserDefaults.standard.setValue(userIdentifier, forKey: "UserSnsId")
                        UserDefaults.standard.setValue("apple", forKey: "UserProvider")
                        // 아이디와 플랫폼 저장
                        
                     // 만약 이미 회원이라면?
                        if tokenData?.status == "회원" {
                            self.dismiss(animated: true, completion: nil)
                        } else {
                            // 신규 회원이라면? -> 아이디 팝업으로 이동
                            guard let popUpVC =
                                    self.storyboard?.instantiateViewController(identifier: "NickVC") as? NickVC else {return}
                            popUpVC.modalPresentationStyle = .overCurrentContext
                            popUpVC.modalTransitionStyle = .crossDissolve
                            self.present(popUpVC, animated: true, completion: nil)
                        }
                        
                        
                    case .failure(let error):
                        print(error)
                        
                    }
                }
            } else {
                // 네트워크 확인 alert 띄워주기

                self.showNetworkModal()
                
            }
            
     
        default:
            break
        }
    }
        
    // Apple ID 연동 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }

    func kakaoLoginSuccess() {
        
        UserApi.shared.me() {(user, error) in // 사용자 정보 가져오기
            if let error = error { // 에러 발생 시
                print(error)
            }
            else { // 정보 잘 가져왔을 때
                
                if NetworkState.isConnected() {
                    
                    let userIdentifier = String((user?.id)!)
                    APIService.shared.login(userIdentifier, "kakao") { [self] result in
                        switch result {
                        
                        case .success(let data):
                            
                            tokenData = data
                            
                            UserDefaults.standard.setValue(tokenData?.accessToken, forKey: "UserToken")
                            // 토큰 저장
                            UserDefaults.standard.setValue(userIdentifier, forKey: "UserSnsId")
                            UserDefaults.standard.setValue("kakao", forKey: "UserProvider")
                            // 아이디와 플랫폼 저장
                            
                         // 만약 이미 회원이라면?
                            if tokenData?.status == "회원" {
                                self.dismiss(animated: true, completion: nil)
                            } else {
                                // 신규 회원이라면? -> 아이디 팝업으로 이동
                                guard let popUpVC =
                                        self.storyboard?.instantiateViewController(identifier: "NickVC") as? NickVC else {return}
                                popUpVC.modalPresentationStyle = .overCurrentContext
                                popUpVC.modalTransitionStyle = .crossDissolve
                                self.present(popUpVC, animated: true, completion: nil)
                            }
                            
                            
                        case .failure(let error):
                            print(error)
                            
                        }
                    }
                } else {
                    // 네트워크 확인 alert 띄워주기

                    self.showNetworkModal()
                    
                }
                
            }
        }
    }
}
