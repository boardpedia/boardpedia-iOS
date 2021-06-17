//
//  TrendingGame.swift
//  boardpedia
//
//  Created by 김민희 on 2021/06/16.
//

import Foundation

struct TrendingGame: Codable {
    let gameIdx: Int
    let name, intro: String
    let imageURL: String
    let saved, saveCount: Int
    let star: Double

    enum CodingKeys: String, CodingKey {
        case gameIdx = "GameIdx"
        case name, intro
        case imageURL = "imageUrl"
        case saved, saveCount, star
    }
}
