//
//  GameDetailData.swift
//  boardpedia
//
//  Created by 김민희 on 2021/06/01.
//

import Foundation

struct GameDetailData: Codable {
    let gameIdx: Int
    let name, intro: String
    let imageURL: String
    let tag: [String]
    let saved: Int
    let star: Double
    let objective: String
    let webURL: String
    let method: String

    enum CodingKeys: String, CodingKey {
        case gameIdx = "GameIdx"
        case name, intro
        case imageURL = "imageUrl"
        case tag, saved, star, objective
        case webURL = "webUrl"
        case method
    }
}
