//
//  UserReviewListData.swift
//  boardpedia
//
//  Created by Hailey on 2021/07/02.
//

import Foundation

// MARK: - UserReviewListData
struct UserReviewListData: Codable {
    let reviewIdx: Int
    let star: Double
    let keyword: [String]
    let boardGame: ReviewBoardGame

    enum CodingKeys: String, CodingKey {
        case reviewIdx = "ReviewIdx"
        case star, keyword
        case boardGame = "BoardGame"
    }
}

struct ReviewBoardGame: Codable {
    let gameIdx: Int
    let name: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case gameIdx = "GameIdx"
        case name
        case imageURL = "imageUrl"
    }
}
