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

    func createPeriodicTransactions(from: [Account], to: [Account], title: String, amount: Double, proportion: [Double], note:String?, url:String? , frequency: frequency, count: Int, referenceData: Date) {
        
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
            
            let double = Double(i)
            let interval = -frequency.rawValue*24*60*60*double
            let date = Date(timeInterval: interval, since: referenceData)
            transaction.date = date
            
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
