//
//  Application.swift
//  goldbac
//
//  Created by adulphan youngmod on 4/8/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation


class Application {
    
    static let calendar = Application().UTCcalendar
    
    var UTCcalendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar
    }
    
    enum accountType : Int16 {
        case cash = 0
        case card = 1
        case bank = 2
        case expense = 3
        case income = 4
        case asset = 5
        case debt = 6
        case equity = 7
    }
    
}





