//
//  DateExtensions.swift
//  goldbac
//
//  Created by adulphan youngmod on 28/7/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation

extension Date {
    
    var monthEnd: Date {
        get{
            let components = DateFormat.main.calendar.dateComponents([.year, .month], from: self)
            let startOfMonth = DateFormat.main.calendar.date(from: components)!
            let firstNextMonth = DateFormat.main.calendar.date(byAdding: .month, value: 1, to: startOfMonth)!
            let endOfMonth = DateFormat.main.calendar.date(byAdding: .day, value: -1, to: firstNextMonth)!
            return endOfMonth
        }
    }
    
//    var standardized: Date {
//        
//        get{
//            let calendar = DateFormat.main.calendar
//            let components = Calendar.current.dateComponents([.day, .month, .year], from: self)
//            let date = calendar.date(from: components)!
//            return date
//        }
//    }

}
