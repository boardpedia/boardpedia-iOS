//
//  SearchResultData.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/11.
//

import Foundation

struct SearchResultData: Codable {
    let gameImage, gameName, gameInfo: String
    let saveNumber: Int
    let startNumber: Float
    var bookMark: Bool
}
