//
//  SimulateTransaction.swift
//  goldbac
//
//  Created by adulphan youngmod on 25/7/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension CoreData {
    
    enum frequency : TimeInterval {
        
        case daily = 1
        case weekly = 7
        case monthly = 30
        case quaterly = 90
        case yearly = 365

    }
    

    func createPeriodicTransactions(from: [Account], to: [Account], title: String, amount: Double, proportion: [Double], note:String?, url:String? , frequency: Calendar.Component, multiple: Int, count: Int, startDate: Int, month: Int, year: Int) {
        
        for i in 0...count-1 {

            let transaction = Transaction(context: context)
            let combine = from + to
            transaction.accounts = NSOrderedSet(array: combine)
            let moneyArray = proportion.map{$0*amount}
            transaction.moneyArray = moneyArray
            transaction.title = title
        
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
            let reference = Calendar.current.date(from: components)!

            let date = Calendar.current.date(byAdding: frequency, value: -i*multiple, to: reference)!
            transaction.date = DateFormat.main.standardized(date: date)

            let recordID = UUID().uuidString
            transaction.recordID = recordID
            print(transaction)
        }
        
        CoreData.main.saveData()
        
    }

    func randomInt(min: Int, max: Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }

}
