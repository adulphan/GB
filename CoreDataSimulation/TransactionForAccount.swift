////
////  TransactionForAccount.swift
////  goldbac
////
////  Created by adulphan youngmod on 27/7/18.
////  Copyright © 2018 goldbac Inc. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//extension CoreDataSimulation {
//
//    func createTransactionsForAnAccount() {
//        
//        let year = components.year!
//        let month = components.month!
//        let day = components.day!
//        
//        var allAccounts = CoreData.main.allAccountsInCoreData!
//        let account = allAccounts[randomInt(min: 0, max: allAccounts.count-1)]
//        let index = allAccounts.index(of: account)
//        allAccounts.remove(at: index!)
//    
//        let opposite = allAccounts[randomInt(min: 0, max: allAccounts.count-1)]
//        
//        createPeriodicTransactions(from: [account], to: [opposite], title: ["PayOut"], amount: [100,200,300,400,500,600,700,800], note: nil, url: nil, frequency: .month, multiple: 1, count: 5, startDate: day, month: month, year: year, flexibleDate: 0)
//        
//        createPeriodicTransactions(from: [opposite], to: [account], title: ["Receive"], amount: [100,200,300,400,500,600,700,800], note: nil, url: nil, frequency: .month, multiple: 1, count: 5, startDate: day-30, month: month, year: year, flexibleDate: 0)
//        
//        CoreData.main.saveData()
//        
//        let transactions = account.transactions?.array as! [Transaction]
//        
//        for transaction in transactions{
//            
//            let index = transaction.accounts.index(of: account)
//            let money = transaction.moneyArray[index]
//            print("\(transaction.recordID):  \(money)")
//            
//        }
//
//    }
//    
//
//}
//
//
//
//
//
//
