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
    let boardGame: BoardGame

    enum CodingKeys: String, CodingKey {
        case reviewIdx = "ReviewIdx"
        case star, keyword
        case boardGame = "BoardGame"
    }
}
