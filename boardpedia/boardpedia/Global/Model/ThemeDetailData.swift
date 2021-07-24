//
//  ThemeDetailData.swift
//  boardpedia
//
//  Created by 김민희 on 2021/07/24.
//

import Foundation

struct ThemeDetailData: Codable {
    let themes: [ThemeData]
    let themeGame: [SearchGameData]
}
