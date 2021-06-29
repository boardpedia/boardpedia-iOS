//
//  UserData.swift
//  boardpedia
//
//  Created by 김민희 on 2021/06/29.
//

import Foundation


struct UserData: Codable {
    let userIdx: Int
    let nickName, level: String

    enum CodingKeys: String, CodingKey {
        case userIdx = "UserIdx"
        case nickName, level
    }
}
