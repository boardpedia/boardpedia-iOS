//
//  APIService.swift
//  boardpedia
//
//  Created by 김민희 on 2021/06/05.
//

import Foundation
import Moya
import Alamofire

struct APIService {
    
    static let shared = APIService()
    // 싱글톤객체로 생성
    let provider = MoyaProvider<APITarget>()
    // MoyaProvider(->요청 보내는 클래스) 인스턴스 생성
    
    func trending(_ jwt: String, completion: @escaping (NetworkResult<[TrendingGame]>)->(Void)) {
        // 홈 - 트렌딩 게임 조회하기
        
        let target: APITarget = .trending(jwt: jwt)
        judgeObject(target, completion: completion)
    }
    
    func saveGame(_ jwt: String, _ gameIdx: Int, completion: @escaping (NetworkResult<Any>)->(Void)) {
        // 북마크 저장
        
        let target: APITarget = .saveGame(jwt: jwt, gameIdx: gameIdx)
        judgeSimpleObject(target, completion: completion)
    }
    
    func saveCancleGame(_ jwt: String, _ gameIdx: Int, completion: @escaping (NetworkResult<Any>)->(Void)) {
        // 북마크 저장 취소
        
        let target: APITarget = .saveCancleGame(jwt: jwt, gameIdx: gameIdx)
        judgeSimpleObject(target, completion: completion)
    }
    
    func login(_ snsId: String, _ provider: String, completion: @escaping (NetworkResult<TokenData>)->(Void)) {
        // 유저 로그인
        
        let target: APITarget = .login(snsId: snsId, provider: provider)
        judgeObject(target, completion: completion)
    }
    
    func todayTheme(_ jwt: String, completion: @escaping (NetworkResult<[ThemeData]>)->(Void)) {
        // 오늘의 테마
        
        let target: APITarget = .theme(jwt: jwt)
        judgeObject(target, completion: completion)
        
    }
    
    func todayThemeDetail(_ jwt: String, _ index: Int, completion: @escaping (NetworkResult<ThemeDetailData>)->(Void)) {
        // 오늘의 테마 상세보기
        
        let target: APITarget = .themeDetail(jwt: jwt, index: index)
        judgeObject(target, completion: completion)
        
    }
    
    func searchResult(_ jwt: String, _ inputWord: String, completion: @escaping (NetworkResult<[SearchGameData]>)->(Void)) {
        // 검색 결과
        
        let target: APITarget = .searchGame(jwt: jwt, inputWord: inputWord)
        judgeObject(target, completion: completion)
        
    }
    
    func searchUser(_ jwt: String, completion: @escaping (NetworkResult<UserData>)->(Void)) {
        // 유저 조회
        
        let target: APITarget = .getUser(jwt: jwt)
        judgeObject(target, completion: completion)
        
    }
    
    func mySaveList(_ jwt: String, completion: @escaping (NetworkResult<[UserSaveListData]>)->(Void)) {
        // 유저가 저장한 게임 목록 조회
        
        let target: APITarget = .mySavedGame(jwt: jwt)
        judgeObject(target, completion: completion)
        
    }
    
    func myReviewList(_ jwt: String, completion: @escaping (NetworkResult<[UserReviewListData]>)->(Void)) {
        // 유저가 작성한 후기 목록 조회
        
        let target: APITarget = .myReivew(jwt: jwt)
        judgeObject(target, completion: completion)
        
    }
    
    func getGameCollection(_ jwt: String,_ pageIdx: Int, _ playerNum: Int, _ level: String, _ tag: [String], _ duration: String, completion: @escaping (NetworkResult<GameCollectionData>)->(Void)) {
        // 게임 모아보기 조회
        
        let target: APITarget = .getFilterGame(jwt: jwt, pageIdx: pageIdx, playerNum: playerNum, level: level, tag: tag, duration: duration)
        judgeObject(target, completion: completion)
        
    }
    
    func getGameDetail(_ jwt: String, _ gameIdx: Int, completion: @escaping (NetworkResult<GameDetailData>)->(Void)) {
        // 보드게임 상세 조회
        
        let target: APITarget = .gameDetail(jwt: jwt, gameIdx: gameIdx)
        judgeObject(target, completion: completion)
    }
    
    func getSimilarGame(_ jwt: String, _ gameIdx: Int, completion: @escaping (NetworkResult<[TrendingGame]>)->(Void)) {
        // 유사한 게임 조회
        
        let target: APITarget = .similarGame(jwt: jwt, gameIdx: gameIdx)
        judgeObject(target, completion: completion)
    }
    
    func getReview(_ jwt: String, _ gameIdx: Int, completion: @escaping (NetworkResult<ReviewData>)->(Void)) {
        // 특정 게임 후기 조회
        
        let target: APITarget = .getReview(jwt: jwt, gameIdx: gameIdx)
        judgeObject(target, completion: completion)
    }
    
    func postGameAdd(_ jwt: String, _ name: String, _ minPlayerNum: Int, _ maxPlayerNum: Int,  _ level: String, _ keyword1: String, _ keyword2: String, _ keyword3: String, completion: @escaping (NetworkResult<ReviewData>)->(Void)) {
        
//        let target: APITarget = .addGame(jwt: jwt, name: name, minPlayerNum: minPlayerNum, maxPlayerNum: maxPlayerNum, level: level, keyword1: keyword1, keyword2: keyword2, keyword3: keyword3)
        
    }
    
    func postReview(_ jwt: String, _ gameIdx: Int, _ star: Float, _ keyword1: String, _ keyword2: String, _ keyword3: String, completion: @escaping (NetworkResult<CompleteReviewData>)->(Void)) {
        
        let target: APITarget = .postReview(jwt: jwt, gameIdx: gameIdx, star: star, keyword1: keyword1, keyword2: keyword2, keyword3: keyword3)
        judgeObject(target, completion: completion)
                
    }
    
    
}


extension APIService {
    
    func judgeObject<T: Codable>(_ target: APITarget, completion: @escaping (NetworkResult<T>) -> Void) {
        provider.request(target) { response in
            switch response {
            case .success(let result):
                do {
                    let decoder = JSONDecoder()
                    let body = try decoder.decode(GenericResponse<T>.self, from: result.data)
                    if let data = body.data {
                        completion(.success(data))
                    }
                } catch {
                    print("구조체를 확인해보세요")
                }
            case .failure(let error):
                completion(.failure(error.response?.statusCode ?? 100))
            }
        }
    }
    
    func judgeSimpleObject(_ target: APITarget, completion: @escaping (NetworkResult<Any>) -> Void) {
        // data를 받아오지 않을때 사용하기!
        provider.request(target) { response in
            switch response {
            case .success(let result):
                do {
                    let decoder = JSONDecoder()
                    let body = try decoder.decode(SimpleData.self, from: result.data)
                    completion(.success(body))
                } catch {
                    print("구조체를 확인해보세요")
                }
            case .failure(let error):
                completion(.failure(error.response!.statusCode))
            }
        }
    }
}


class NetworkState {
    class func isConnected() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
