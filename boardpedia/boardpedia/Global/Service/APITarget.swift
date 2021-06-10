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
    
    case getTotalGame(jwt: String, pageIdx: Int) // 모든 게임 조회
    case getFilterGame(jwt: String, playerNum: Int, level: String, tag: [String], duration: String) // 조건에 맞는 보드게임 조회하기
    case gameDetail(jwt: String, gameIdx: Int) // 게임 상세 조회
    case postReview(jwt: String, gameIdx: Int) // 게임 리뷰 작성
    case getReview(jwt: String, gameIdx: Int) // 게임 리뷰 조회
    case similarGame(jwt: String, gameIdx: Int) // 유사 보드게임 조회
    
    case getUser(jwt: String) // 회원 정보 조회
    case mySavedGame(jwt: String) // 회원이 저장한 게임 조회
    case myReivew(jwt: String) // 회원이 작성한 리뷰 조회
    
    case login(snsId: String, provider: String, nickName: String) // 로그인 , 회원가입
    
    
    
    
    
    
}
