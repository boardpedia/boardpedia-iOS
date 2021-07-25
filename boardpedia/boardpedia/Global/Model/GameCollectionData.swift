//
//  GameCollectionData.swift
//  boardpedia
//
//  Created by 김민희 on 2021/07/25.
//

import Foundation

struct GameCollectionData: Codable {
    let totalNum: Int
    let searchedGame: [SearchGameData]
}
