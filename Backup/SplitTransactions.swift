////
////  SplitTransactions.swift
////  goldbac
////
////  Created by adulphan youngmod on 29/7/18.
////  Copyright © 2018 goldbac Inc. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//extension CoreDataSimulation {
//    
//    func createPeriodicSplitTransactions(from: [Account], to: [Account], title: [String], amount: [Double], moneySTD:[Double], note:String?, url:String? , frequency: Calendar.Component, multiple: Int, count: Int, startDate: Int, month: Int, year: Int, flexibleDate:Int) {
//        
//        for i in 0...count-1 {
//            
//            let transaction = Transaction(context: context)
//            let combine = from + to
//            transaction.accounts = NSOrderedSet(array: combine)
//            
//            let randomAmount = amount[randomInt(min: 0, max: amount.count-1)]
//            let moneyArray:[Double] = moneySTD.map{$0*randomAmount}
//            transaction.moneyArray = moneyArray
//            
//            let randomTitle = title[randomInt(min: 0, max: title.count-1)]
//            transaction.title = randomTitle
//            
//            if let text = note {
//                transaction.note = text
//            }
//            
//            if let text = url {
//                transaction.url = text
//            }
//            
//            var components = DateComponents()
//            components.day = startDate
//            components.month = month
//            components.year = year
//            let reference = Calendar.current.date(from: components)!
//            let addFlex = randomInt(min: -flexibleDate, max: +flexibleDate)
//            
//            var date = Calendar.current.date(byAdding: frequency, value: -i*multiple, to: reference)!
//            date = Calendar.current.date(byAdding: .day, value: addFlex, to: date)!
//            
//            transaction.date = DateFormat.main.standardized(date: date)
//            transaction.modified = DateFormat.main.standardized(date: date)
//            
//            let recordID = UUID().uuidString
//            transaction.recordID = recordID
//            
//        }
//        
//        
//        
//    }
//
//
//
//}
