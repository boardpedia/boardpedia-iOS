//
//  SearchGameData.swift
//  boardpedia
//
//  Created by 김민희 on 2021/06/21.
//

import Foundation

struct SearchGameData: Codable {
    let gameIdx: Int
    let name, intro, imageURL: String
    let saved, saveCount: Int
    let star: Double

    enum CodingKeys: String, CodingKey {
        case gameIdx = "GameIdx"
        case name, intro
        case imageURL = "imageUrl"
        case saved, saveCount, star
    }
}
