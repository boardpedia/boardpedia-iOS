//
//  MyReviewData.swift
//  boardpedia
//
//  Created by 김민희 on 2021/05/13.
//

import Foundation

struct MyReviewData: Codable {
    let gameImage: String
    let gameName, firstKeyword, secondKeyword: String
    let star: Float
}
