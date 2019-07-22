//
//  DateExtension.swift
//  qiqi_ios
//
//  Created by design on 2018/9/19.
//  Copyright © 2018年 design. All rights reserved.
//

import Foundation

extension Date {
    
    ///日期格式 "yyyy-MM-dd HH:mm"
    func getDate() -> String {
        return self.getDate("yyyy-MM-dd HH:mm")
    }

    ///
    func getDate(_ dataFomartStr: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dataFomartStr
        let timeStr = dateFormatter.string(from: self)
        return timeStr
    }
    
    ///年份
    func getYear() -> String {
        let dateFormatter = DateFormatter()
        ///年份
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.string(from: self)
        return year
    }
    
    ///月份
    func getMouth() -> String {
        let dateFormatter = DateFormatter()
        ///月份
        dateFormatter.dateFormat = "M"
        let year = dateFormatter.string(from: self)
        return year
    }
    
    ///日
    func getDay() -> String {
        let dateFormatter = DateFormatter()
        ///日
        dateFormatter.dateFormat = "d"
        let year = dateFormatter.string(from: self)
        return year
    }
    
    ///时间
    func getHour() -> String {
        let dateFormatter = DateFormatter()
        ///时间
        dateFormatter.dateFormat = "HH:mm"
        let year = dateFormatter.string(from: self)
        return year
    }
    
    ///获取当前时间戳
    static func currentTimeStamp() -> String {
        let date = Date()
        
        return String(date.timeIntervalSince1970)
    }
    
    ///获取某年某月有多少天,包含润月
    ///year    年份
    ///mouth   月份
    static func daysInCurrentMouth(_ year: Int, mouth: Int) -> Int {
        var isLeap = false
        if year % 100 == 0 {
            isLeap = year % 400 == 0
        }else {
            isLeap = year % 4 == 0
        }
        if mouth == 2 {
            return isLeap ? 29 : 28
        }else if [4,6,9,11].contains(mouth) {
            return 30
        }else {
            return 31
        }
    }
}
