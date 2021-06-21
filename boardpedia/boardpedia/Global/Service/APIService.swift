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
