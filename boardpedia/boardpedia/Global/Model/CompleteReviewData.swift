//
//  CompleteReviewData.swift
//  boardpedia
//
//  Created by Hailey on 2021/08/10.
//

import Foundation

struct CompleteReviewData: Codable {
    let reviewIdx: Int
    let gameIdx: String
    let star, userIdx: Int
    let keyword, updatedAt, createdAt: String

    enum CodingKeys: String, CodingKey {
        case reviewIdx = "ReviewIdx"
        case gameIdx = "GameIdx"
        case star
        case userIdx = "UserIdx"
        case keyword, updatedAt, createdAt
    }
}
