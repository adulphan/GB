//
//  DateFormat.swift
//  goldbac
//
//  Created by adulphan youngmod on 26/7/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation

class DateFormat {
    
    static let main = DateFormat()
    
    var calendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar
    }
    
    func standardized(date: Date) -> Date {
        let components = Calendar.current.dateComponents([.day, .month, .year], from: date)
        let date = calendar.date(from: components)!
        return date
    }

}









