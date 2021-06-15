//
//  APITarget.swift
//  boardpedia
//
//  Created by 김민희 on 2021/06/10.
//

import Foundation
import Moya

enum APITarget {
    // case 별로 api 나누기
    
    case trending(jwt: String) // 트렌딩 게임 조회하기, 인기 검색어 조회
    case theme(jwt: String) // 오늘의 추천테마 조회하기
    case themeDetail(jwt: String, index: Int) // 추천테마 상세 조회
    case searchGame(jwt: String, inputWord: String) // 게임 검색 및 검색결과 조회
    case saveGame(jwt: String, gameIdx: Int) // 보드게임 저장하기
    case saveCancleGame(jwt: String, gameIdx: Int) // 보드게임 저장 취소하기
    
//    case getTotalGame(jwt: String, pageIdx: Int) // 모든 게임 조회
    case getFilterGame(jwt: String, pageIdx: Int, playerNum: Int, level: String, tag: [String], duration: String) // 조건에 맞는 보드게임 조회하기
    case gameDetail(jwt: String, gameIdx: Int) // 게임 상세 조회
    case postReview(jwt: String, gameIdx: Int) // 게임 리뷰 작성
    case getReview(jwt: String, gameIdx: Int) // 게임 리뷰 조회
    case similarGame(jwt: String, gameIdx: Int) // 유사 보드게임 조회
    case addGame(jwt: String, name: String, minPlayerNum: Int, maxPlayerNum: Int, level: String, keyword1: String, keyword2: String, keyword3: String, duration: String) // 게임 추가하기
    
    case getUser(jwt: String) // 회원 정보 조회
    case mySavedGame(jwt: String) // 회원이 저장한 게임 조회
    case myReivew(jwt: String) // 회원이 작성한 리뷰 조회
    case nickName(jwt: String, nickName: String) // 닉네임 등록 및 수정
    
    case login(snsId: String, provider: String) // 로그인 , 회원가입
    case deleteUser(jwt: String) // 회원 탈퇴하기

    
}

// MARK: TargetType Protocol 구현

extension APITarget: TargetType {
    
    var baseURL: URL {
        // baseURL - 서버의 도메인
        
        return URL(string: "https://52.78.68.188:3000/")!
    }

    var path: String {
        // path - 서버의 도메인 뒤에 추가 될 경로
        switch self {
        case .trending:
            return ""
        }
    }
    
    var method: Moya.Method {
        // method - 통신 method (get, post, put, delete ...)
        switch self {
        case .login, .signup, .postFeed:
            return .post
        case .shuffleMain, .categoryFeed, .todayQuestion:
            return .get
        case .deleteFeed:
            return .delete
        }
    }
    
    var sampleData: Data {
        // sampleDAta - 테스트용 Mock Data
        return Data()
    }
    
    var task: Task {
        // task - 리퀘스트에 사용되는 파라미터 설정
        // 파라미터가 없을 때는 - .requestPlain
        // 파라미터 존재시에는 - .requestParameters(parameters: ["first_name": firstName, "last_name": lastName], encoding: JSONEncoding.default)
        
        switch self {
        case .login(let uuid), .signup(let uuid):
            return .requestParameters(parameters: ["uuid" : uuid], encoding: JSONEncoding.default)
            
        case .shuffleMain, .categoryFeed, .todayQuestion, .deleteFeed:
            return .requestPlain
        
        case .postFeed(_, let image, let contents, _):
            let postString = MultipartFormData(provider: .data(contents.data(using: .utf8)!), name: "postString")
            let imageData = MultipartFormData(provider: .data(image.jpegData(compressionQuality: 1.0)!), name: "image", fileName: "jpeg", mimeType: "image/jpeg")
            let multipartData = [imageData, postString]
            return .uploadMultipart(multipartData)
            
        }
    }
    
    var validationType: Moya.ValidationType {
        // validationType - 허용할 response의 타입
        return .successAndRedirectCodes
    }
    
    var headers: [String : String]? {
        // headers - HTTP header
        switch self {
        case .login, .signup:
            return ["Content-Type" : "application/json"]
        case .shuffleMain(let jwt), .categoryFeed(_, let jwt), .todayQuestion(_, let jwt), .postFeed(_, _, _, let jwt), .deleteFeed(_, let jwt):
            return ["Content-Type" : "application/json", "jwt" : jwt]
        }
    }
    
