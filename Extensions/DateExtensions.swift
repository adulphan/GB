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
            let components = Calendar.current.dateComponents([.year, .month], from: self)
            let startOfMonth = Calendar.current.date(from: components)!
            let firstNextMonth = Calendar.current.date(byAdding: .month, value: 1, to: startOfMonth)!
            let endOfMonth = Calendar.current.date(byAdding: .day, value: -1, to: firstNextMonth)!
            let adjusted = endOfMonth.adjustedToAppCalendar
            return adjusted
        }
    }
    
    var adjustedToAppCalendar: Date {
        
        get{
            let calendar = Application.calendar
            let components = Calendar.current.dateComponents([.day, .month, .year], from: self)
            let date = calendar.date(from: components)!
            return date
        }
    }

}
