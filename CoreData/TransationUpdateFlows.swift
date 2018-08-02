////
////  TransationUpdateFlows.swift
////  goldbac
////
////  Created by adulphan youngmod on 28/7/18.
////  Copyright © 2018 goldbac Inc. All rights reserved.
////
//
//import Foundation
//import CoreData
//import UIKit
//
//extension Transaction {
//    
//    func editFlows() {
//        
//        if cachedOldValues?.filter({(key,value) -> Bool in
//            key == "moneyArray" || key == "accounts" || key == "date"
//        }).count == 0 { return }
//        
//        var oldMoneyArray: [Double]
//        var oldAccounts: NSOrderedSet
//        var oldDate: Date
//        
//        if let moneyArray = cachedOldValues?.filter({(key,value) -> Bool in
//            key == "moneyArray"
//        }).first {
//            oldMoneyArray = moneyArray.value as! [Double]
//        } else {
//            oldMoneyArray = self.moneyArray
//        }
//        
//        if let accountArray = cachedOldValues?.filter({(key,value) -> Bool in
//            key == "accounts"
//        }).first {
//            oldAccounts = accountArray.value as! NSOrderedSet
//        } else {
//            oldAccounts = self.accounts
//        }
//        
//        if let date = cachedOldValues?.filter({(key,value) -> Bool in
//            key == "date"
//        }).first {
//            oldDate = date.value as! Date
//        } else {
//            oldDate = self.date
//        }
//        
//        handleUpdateBalanceIn(accounts: oldAccounts, moneyArray: oldMoneyArray, date: oldDate, isInsert:false)
//        handleUpdateBalanceIn(accounts: self.accounts, moneyArray: self.moneyArray, date: self.date, isInsert:true)
//        
//        if CoreDataSimulation.main.isSimulating == false {
//            CoreData.main.saveData()
//        }
//        
//    }
//
//    func deleteFlows() {
//
//        handleUpdateBalanceIn(accounts: self.accounts, moneyArray: self.moneyArray, date: self.date, isInsert:false)
//        if CoreDataSimulation.main.isSimulating == false {
//            CoreData.main.saveData()
//        }
//    }
//
//    func insertFlows() {
//        
//        handleUpdateBalanceIn(accounts: self.accounts, moneyArray: self.moneyArray, date: self.date, isInsert:true)
//        if CoreDataSimulation.main.isSimulating == false {
//            CoreData.main.saveData()
//        }
//    }
//    
//    private func handleUpdateBalanceIn(accounts: NSOrderedSet, moneyArray: [Double], date: Date, isInsert:Bool) {
//        
//        let accounts = accounts.array as! [Account]
//        let moneyArray = isInsert ? moneyArray : moneyArray.map{$0*(-1)}
//        
//        for account in accounts {
//            
//            let index = accounts.index(of: account)!
//            let monthEnd = DateFormat.main.standardized(date: date.monthEnd)
//            let monthlyArray = account.monthlyArray
//            
//            let withSameMonth = monthlyArray.filter { (monthly) -> Bool in
//                monthly.endDate == monthEnd
//            }
//            
//            if let alreadyCreated = withSameMonth.first {
//                alreadyCreated.balance += moneyArray[index]
//                alreadyCreated.flow += moneyArray[index]
//                
//                let mIndex = monthlyArray.index(of: alreadyCreated)!
//                if mIndex != 0 {
//                    for i in 0...mIndex-1 {
//                        (account.monthly?.object(at: i) as! Monthly).balance += moneyArray[index]
//                    }
//                }
//                
//            } else {
//                
//                let monthly = Monthly(context: CoreData.main.context)
//                monthly.endDate = monthEnd
//                if let mIndex = monthlyArray.index(where: {$0.endDate < monthEnd}) {
//                    monthly.balance = monthlyArray[mIndex].balance + moneyArray[index]
//                    monthly.flow = moneyArray[index]
//                    account.insertIntoMonthly(monthly, at: mIndex)
//                    if mIndex != 0 {
//                        for i in 0...mIndex-1 {
//                            (account.monthly?.object(at: i) as! Monthly).balance += moneyArray[index]
//                        }
//                    }
//                    
//                } else {
//                    for object in account.monthly! {
//                        (object as! Monthly).balance += moneyArray[index]
//                    }
//                    monthly.balance = account.beginBalance + moneyArray[index]
//                    monthly.flow = moneyArray[index]
//                    account.addToMonthly(monthly)
//                }
//                
//            }
//            
//        }
//
//        
//    }
//
//}
//
//
//
//
//
