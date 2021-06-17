//
//  ThemeData.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/10.
//

import Foundation

struct ThemeData: Codable {
    let themeIdx: Int
    let name, detail: String
    let imageURL: String
    let tag: [String]

    enum CodingKeys: String, CodingKey {
        case themeIdx = "ThemeIdx"
        case name, detail
        case imageURL = "imageUrl"
        case tag
    }
}
