//
//  UserSaveListData.swift
//  boardpedia
//
//  Created by 김민희 on 2021/06/29.
//

import Foundation

// MARK: - UserSaveListData
struct UserSaveListData: Codable {
    let savedIdx: Int
    let boardGame: BoardGame

    enum CodingKeys: String, CodingKey {
        case savedIdx = "SavedIdx"
        case boardGame = "BoardGame"
    }
}

// MARK: - BoardGame
struct BoardGame: Codable {
    let gameIdx: Int
    let name, intro: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case gameIdx = "GameIdx"
        case name, intro
        case imageURL = "imageUrl"
    }
}
