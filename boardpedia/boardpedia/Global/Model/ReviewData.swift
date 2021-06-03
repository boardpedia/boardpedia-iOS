//
//  ReviewData.swift
//  boardpedia
//
//  Created by 김민희 on 2021/06/03.
//

import Foundation

// MARK: - ReviewData
struct ReviewData: Codable {
    let reviewInfo: ReviewInfo
    let reviews: [Review]
}

// MARK: - ReviewInfo
struct ReviewInfo: Codable {
    let averageStar: Double
    let topKeywords: [String]
}

// MARK: - Review
struct Review: Codable {
    let reviewIdx: Int
    let star: Double
    let keyword: [String]
    let createdAt: String
    let userIdx: Int
    let nickName, level: String

    enum CodingKeys: String, CodingKey {
        case reviewIdx = "ReviewIdx"
        case star, keyword, createdAt
        case userIdx = "UserIdx"
        case nickName, level
    }
}
