////
////  Helper.swift
////  goldbac
////
////  Created by adulphan youngmod on 26/7/18.
////  Copyright © 2018 goldbac Inc. All rights reserved.
////
//
//import Foundation
//
//extension CoreDataSimulation {
//    
//    func printAllTransactions() {
//        
//        do {
//            
//            let fetchRequest = try context.fetch(Transaction.fetchRequest())
//            var transactions = fetchRequest as! [Transaction]
//            transactions.sort { (s1, s2) -> Bool in
//                s1.date >= s2.date
//            }
//            
//            print("Number of transactions: \(fetchRequest.count)")
//            for transaction in transactions {
//                let listFrom = listOfAccounts(accounts: transaction.fromAccounts)
//                let listTo = listOfAccounts(accounts: transaction.toAccounts)
//                printSequenceOf(contents: ["\(transaction.date)","\(transaction.title ?? "No Title")", "\(transaction.totalAmount)",listFrom, listTo])
//            }
//            
//        } catch {print("Printing transactions failed")}
//    }
//    
//    func printAllAccounts() {
//        
//        do {
//            
//            let fetchRequest = try context.fetch(Account.fetchRequest())
//            let accounts = fetchRequest as! [Account]
//            print("Number of accounts: \(fetchRequest.count)")
//            for account in accounts {
//                print("\(account.name): \(account.transactions?.count ?? 00000)")
//            }
//            
//        } catch {print("Printing accounts failed")}
//        
//    }
//    
//    func randomInt(min: Int, max: Int) -> Int {
//        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
//    }
//    
//    func printSequenceOf(contents: [String]) {
//        
//        var allText = ""
//        for string in contents {
//            if string == contents.first! {
//                allText += string
//                
//            } else {
//                allText += " : \(string)"
//            }
//            
//        }
//        
//        print(allText)
//    }
//    
//    func listOfAccounts(accounts:[Account]) -> String {
//        var list = ""
//        for account in accounts {
//            
//            if account == accounts.first {
//                
//                list += "\(account.name)"
//            } else if account == accounts.last {
//                
//                list += ", and \(account.name)"
//            } else {
//                
//                list += ", \(account.name)"
//            }
//        }
//        return list
//        
//    }
//    
//    
//    
//}
