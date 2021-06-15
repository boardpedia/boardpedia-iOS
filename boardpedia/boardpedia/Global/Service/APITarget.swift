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
    case addGame(jwt: String, name: String, minPlayerNum: Int, maxPlayerNum: Int, level: String, keyword1: String, keyword2: String, keyword3: String, duration: String) // 게임 추가하기
    case saveGame(jwt: String, gameIdx: Int) // 보드게임 저장하기
    case saveCancleGame(jwt: String, gameIdx: Int) // 보드게임 저장 취소하기
    
//    case getTotalGame(jwt: String, pageIdx: Int) // 모든 게임 조회
    case getFilterGame(jwt: String, pageIdx: Int, playerNum: Int, level: String, tag: [String], duration: String) // 조건에 맞는 보드게임 조회하기
    case gameDetail(jwt: String, gameIdx: Int) // 게임 상세 조회
    case postReview(jwt: String, gameIdx: Int, star: Float, keyword1: String, keyword2: String, keyword3: String) // 게임 리뷰 작성
    case getReview(jwt: String, gameIdx: Int) // 게임 리뷰 조회
    case similarGame(jwt: String, gameIdx: Int) // 유사 보드게임 조회
    
    case getUser(jwt: String) // 회원 정보 조회
    case mySavedGame(jwt: String) // 회원이 저장한 게임 조회
    case myReivew(jwt: String) // 회원이 작성한 리뷰 조회
    case nickName(jwt: String, nickName: String) // 닉네임 등록 및 수정
    case deleteUser(jwt: String) // 회원 탈퇴하기
    
    case login(snsId: String, provider: String) // 로그인 , 회원가입

    
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
            return "/game/trending"
        case .theme:
            return "/theme"
        case .themeDetail(_,let index):
            return "/theme/\(index)"
        case .searchGame:
            return "/game/search"
        case .addGame:
            return "/game/add"
        case .saveGame, .saveCancleGame:
            return "/game/save"
            
        case .getFilterGame(_, let pageIdx, _, _, _, _):
            return "/game/filter/\(pageIdx)"
        case .gameDetail(_, let gameIdx):
            return "/game/detail/\(gameIdx)"
        case .postReview(_, let gameIdx, _, _, _, _), .getReview(_, let gameIdx):
            return "/game/review/\(gameIdx)"
        case .similarGame(_, let gameIdx):
            return "/game/similar/\(gameIdx)"
            
        case .getUser, .nickName, .deleteUser:
            return "/user"
        case .mySavedGame:
            return "/user/saved"
        case .myReivew:
            return "/user/played"
            
        case .login:
            return "/user/login"

        }
    }
    
    var method: Moya.Method {
        // method - 통신 method (get, post, put, delete ...)
        
        switch self {
        case .trending, .theme, .themeDetail, .gameDetail, .getReview, .similarGame, .getUser, .mySavedGame , .myReivew:
            return .get
            
        case .searchGame, .addGame, .saveGame, .getFilterGame, .postReview, .login:
            return .post
            
        case .saveCancleGame, .deleteUser:
            return .delete
            
        case .nickName:
            return .put
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
        
        case .trending, .theme, .themeDetail, .gameDetail, .getReview, .similarGame, .getUser, .deleteUser, .mySavedGame, .myReivew:
            return .requestPlain
        
        case .searchGame(_, let inputWord):
            return .requestParameters(parameters: ["inputWord" : inputWord], encoding: JSONEncoding.default)
            
        case .addGame(_, let name, let minPlayerNum, let maxPlayerNum, let level, let keyword1, let keyword2, let keyword3, let duration):
            return .requestParameters(parameters: ["name" : name, "minPlayerNum" : minPlayerNum, "maxPlayerNum" : maxPlayerNum, "level" : level, "keyword1" : keyword1, "keyword2" : keyword2, "keyword3" : keyword3, "duration" : duration], encoding: JSONEncoding.default)
        
        case .saveGame(_, let gameIdx), .saveCancleGame(_, let gameIdx):
            return .requestParameters(parameters: ["gameIdx" : gameIdx], encoding: JSONEncoding.default)
            
        case .getFilterGame(_, _, let playerNum, let level, let tag, let duration):
            return .requestParameters(parameters: ["playerNum" : playerNum, "level" : level, "tag" : tag, "duration" : duration], encoding: JSONEncoding.default)
            
        case .postReview(_, _, let star, let keyword1, let keyword2, let keyword3):
            return .requestParameters(parameters: ["star" : star, "keyword1" : keyword1, "keyword2" : keyword2, "keyword3" : keyword3], encoding: JSONEncoding.default)
            
        case .nickName(_, let nickName):
            return .requestParameters(parameters: ["nickName" : nickName], encoding: JSONEncoding.default)
        
        case .login(let snsId, let provider):
            return .requestParameters(parameters: ["snsId" : snsId, "provider" : provider], encoding: JSONEncoding.default)
            
        }
    }
    
    var validationType: Moya.ValidationType {
        // validationType - 허용할 response의 타입
        return .successAndRedirectCodes
    }
    
    var headers: [String : String]? {
        // headers - HTTP header
        switch self {
        case .login :
            return ["Content-Type" : "application/json"]
            
        case .trending(let jwt), .theme(let jwt), .themeDetail(let jwt, _), .searchGame(let jwt, _), .addGame(let jwt, _, _, _, _, _, _, _, _), .saveGame(let jwt, _), .saveCancleGame(let jwt, _), .getFilterGame(let jwt, _, _, _, _, _), .gameDetail(let jwt, _), .postReview(let jwt, _, _, _, _, _), .getReview(let jwt, _), .similarGame(let jwt, _), .getUser(let jwt), .mySavedGame(let jwt), .myReivew(let jwt), .nickName(let jwt, _), .deleteUser(let jwt):
            return ["Content-Type" : "application/json", "jwt" : jwt]
        }
    }
    
}
    
