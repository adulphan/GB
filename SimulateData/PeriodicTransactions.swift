//
//  PeriodicTransactions.swift
//  goldbac
//
//  Created by adulphan youngmod on 26/7/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation
import UIKit

extension SimulateData {
    
    func createPeriodicTransactions(from: [Account], to: [Account], title: [String], amount: [Double], note:String?, url:String? , frequency: Calendar.Component, multiple: Int, count: Int, startDate: Int, month: Int, year: Int, flexibleDate:Int) {
        
        for i in 0...count-1 {
            
            let transaction = Transaction()
            
            let randomFromAccount = from[randomInt(min: 0, max: from.count-1)]
            let randomToAccount = to[randomInt(min: 0, max: to.count-1)]
            let combine = [randomFromAccount,randomToAccount]
            transaction.accounts = combine
            
            let randomAmount = amount[randomInt(min: 0, max: amount.count-1)]
            
            let moneyArray:[Double] = [-1,1].map{$0*randomAmount}
            transaction.flowArray = moneyArray
            
            let randomTitle = title[randomInt(min: 0, max: title.count-1)]
            transaction.title = randomTitle
            
            if let text = note {
                transaction.note = text
            }
            
            if let text = url {
                transaction.url = text
            }
            
            var components = DateComponents()
            components.day = startDate
            components.month = month
            components.year = year
            let reference = Calendar.current.date(from: components)?.adjustedToAppCalendar
            let addFlex = randomInt(min: -flexibleDate, max: +flexibleDate)
            
            var date = Application.calendar.date(byAdding: frequency, value: -i*multiple, to: reference!)
            date = Application.calendar.date(byAdding: .day, value: addFlex, to: date!)
            
            transaction.date = date
            transaction.modified = Date()
            
            transaction.addToCoreData()
            
        }

    }
    
    func createPeriodicSplitTransactions(from: [Account], to: [Account], title: [String], amount: [Double], flowSTD:[Double], note:String?, url:String? , frequency: Calendar.Component, multiple: Int, count: Int, startDate: Int, month: Int, year: Int, flexibleDate:Int) {

        for i in 0...count-1 {

            let transaction = Transaction()
            let combine = from + to
            transaction.accounts = combine

            let randomAmount = amount[randomInt(min: 0, max: amount.count-1)]
            let flowArray:[Double] = flowSTD.map{$0*randomAmount}
            transaction.flowArray = flowArray

            let randomTitle = title[randomInt(min: 0, max: title.count-1)]
            transaction.title = randomTitle

            if let text = note {
                transaction.note = text
            }

            if let text = url {
                transaction.url = text
            }

            var components = DateComponents()
            components.day = startDate
            components.month = month
            components.year = year
            let reference = Calendar.current.date(from: components)?.adjustedToAppCalendar
            let addFlex = randomInt(min: -flexibleDate, max: +flexibleDate)
            
            var date = Application.calendar.date(byAdding: frequency, value: -i*multiple, to: reference!)
            date = Application.calendar.date(byAdding: .day, value: addFlex, to: date!)

            transaction.date = date
            transaction.modified = Date()
            
            transaction.addToCoreData()

        }



    }

}







