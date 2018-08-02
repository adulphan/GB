//
//  CoreData.swift
//  goldbac
//
//  Created by adulphan youngmod on 25/7/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreData {

    static let app = CoreData()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//
//    var allAccountsInCoreData:[Account]? {get{return getAllAccounts()}}
//    var allTransactionsInCoreData:[Transaction]? {get{return getAllTransactions()}}
//    var allMonthlyInCoreData:[Monthly]? {get{return getAllMonthly()}}
    
    enum AccountType : Int {
        case cash = 0
        case card = 1
        case bank = 2
        case expense = 3
        case income = 4
        case asset = 5
        case debt = 6
        case equity = 7
    }

//    private func getAccountsWithType(type: AccountType) -> [Account]? {
//        let allAccounts = allAccountsInCoreData
//        let accountWithType = allAccounts?.filter({ (account) -> Bool in
//            return account.type == Int16(type.rawValue)
//        })
//        guard let accountArray = accountWithType else {
//            print("No account with type: \(type)")
//            return nil
//        }
//        return accountArray
//    }
//
//    private func getAllAccounts() -> [Account]? {
//        do {
//            let fetchRequest = try context.fetch(Account.fetchRequest())
//            let accounts = fetchRequest as! [Account]
//            if accounts.count == 0 {
//                print("No account in CoreData")
//            }
//            return accounts
//        } catch {
//            print("Loading Account failed")
//            return nil
//        }
//    }
//
//    private func getAllTransactions() -> [Transaction]? {
//        do {
//            let fetchRequest = try context.fetch(Transaction.fetchRequest())
//            let transactions = (fetchRequest as! [Transaction]).sorted { (s1, s2) -> Bool in
//                s1.date > s2.date
//            }
//            if transactions.count == 0 {
//                print("No transaction in CoreData")
//            }
//            return transactions
//        } catch {
//            print("Loading Account failed")
//            return nil
//        }
//    }
//
//    private func getAllMonthly() -> [Monthly]? {
//        do {
//            let fetchRequest = try context.fetch(Monthly.fetchRequest())
//            let monthlyArray = fetchRequest as! [Monthly]
//            if monthlyArray.count == 0 {
//                print("No flow in CoreData")
//            }
//            return monthlyArray
//        } catch {
//            print("Loading Flow failed")
//            return nil
//        }
//    }


    
}








