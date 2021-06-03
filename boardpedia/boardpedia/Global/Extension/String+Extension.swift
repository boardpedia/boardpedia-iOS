//
//  String+Extension.swift
//  boardpedia
//
//  Created by 김민희 on 2021/06/03.
//

import Foundation

extension String {
    
    func recordTime() -> String {
        // Date 스트링에서 날짜만 추출하기
        
        var format = "yyyy-MM-dd HH:mm:ss"
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        guard let tempDate = formatter.date(from: self) else {
            return ""
        }
        
        format = "MM/dd"
        formatter.dateFormat = format
        
        return formatter.string(from: tempDate)
    }
    
}
