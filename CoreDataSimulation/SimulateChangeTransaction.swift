////
////  SimulateChangeTransaction.swift
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
//    func simulateEditTransaction() {
//        
//        allTransactions = CoreData.main.allTransactionsInCoreData!
//        allAccounts = CoreData.main.allAccountsInCoreData!
//        
//        let transaction = allTransactions[randomInt(min: 0, max: allTransactions.count-1)]
//        transaction.moneyArray = transaction.moneyArray.map{$0*10}
//        
//        
//        let date = Calendar.current.date(byAdding: .month, value: 0, to: Date())!
//        transaction.date = DateFormat.main.standardized(date: date)
//        
//        
//        print("edtited: \(transaction.title ?? "No Title") : \((transaction.accounts.array as! [Account]).map{$0.name})")
//        
//        let index = allTransactions.index(of: transaction)
//        allTransactions.remove(at: index!)
//        
//        let transaction_2 = allTransactions[randomInt(min: 0, max: allTransactions.count-1)]
//        let date2 = Calendar.current.date(byAdding: .month, value: -200, to: Date())!
//        transaction_2.date = DateFormat.main.standardized(date: date2)
//
//        print("edtited: \(transaction_2.title ?? "No Title") : \((transaction_2.accounts.array as! [Account]).map{$0.name})")
//        
//        let index2 = allTransactions.index(of: transaction_2)
//        allTransactions.remove(at: index2!)
//        
//        let transaction_3 = allTransactions[randomInt(min: 0, max: allTransactions.count-1)]
//
//        let newAccount = allAccounts[randomInt(min: 0, max: allAccounts.count-1)]
//        let nIndex = allAccounts.index(of: newAccount)
//        
//        allAccounts.remove(at: nIndex!)
//        let newAccount2 = allAccounts[randomInt(min: 0, max: allAccounts.count-1)]
//
//        transaction_3.setValue(NSOrderedSet(array: [newAccount,newAccount2]), forKey: "accounts")
//        
//        print("edtited: \(transaction_3.title ?? "No Title") : \((transaction_3.accounts.array as! [Account]).map{$0.name})")
//        
//        //CoreData.main.saveData()
//        
//    }
//    
//    func simulateDeleteTransaction() {
//        
//        
//        
//        allTransactions = CoreData.main.allTransactionsInCoreData!
//        let transaction = allTransactions[randomInt(min: 0, max: allTransactions.count-1)]
//        print("deleted: \(transaction.title ?? "No Title") : \((transaction.accounts.array as! [Account]).map{$0.name}) : \(transaction.moneyArray)")
//        CoreData.main.context.delete(transaction)
//        
//        
//        //CoreData.main.saveData()
//        
//    }
//    
//    func simulateAddTransaction() {
//        
//        allTransactions = CoreData.main.allTransactionsInCoreData!
//        let transaction = allTransactions[randomInt(min: 0, max: allTransactions.count-1)]
//        
//        let newTransaction = Transaction(context: CoreData.main.context)
//        newTransaction.title = transaction.title
//        newTransaction.date = DateFormat.main.standardized(date: Date())
//        newTransaction.modified = DateFormat.main.standardized(date: Date())
//        newTransaction.recordID = UUID().uuidString
//        newTransaction.accounts = transaction.accounts
//        newTransaction.moneyArray = transaction.moneyArray
//        print("added: \(transaction.title ?? "No Title") : \((transaction.accounts.array as! [Account]).map{$0.name})")
//        //CoreData.main.saveData()
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
