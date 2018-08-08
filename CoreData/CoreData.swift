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

    static let shared = CoreData()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var allAccountsInCoreData:[AccountCoreData]? {get{return getAllAccounts()}}
    var allTransactionsInCoreData:[TransactionCoreData]? {get{return getAllTransactions()}}
    var allMonthInCoreData:[MonthCoreData]? {get{return getAllMonth()}}
    var allPending:[CKPending]? {get{return getAllPending()}}
    
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

    private func getAllAccounts() -> [AccountCoreData]? {
        do {
            let fetchRequest = try context.fetch(AccountCoreData.fetchRequest())

            let accounts = (fetchRequest as! [AccountCoreData]).sorted { (a1, a2) -> Bool in
                a1.modified! > a2.modified!
            }
            if accounts.count == 0 {
                print("No account in CoreData")
            }
            return accounts
        } catch {
            print("Loading Account failed")
            return nil
        }
    }

    private func getAllTransactions() -> [TransactionCoreData]? {
        do {
            let fetchRequest = try context.fetch(TransactionCoreData.fetchRequest())
            let transactions = (fetchRequest as! [TransactionCoreData]).sorted { (s1, s2) -> Bool in
                s1.date! > s2.date!
            }
            if transactions.count == 0 {
                print("No transaction in CoreData")
            }
            return transactions
        } catch {
            print("Loading Account failed")
            return nil
        }
    }

    private func getAllMonth() -> [MonthCoreData]? {
        do {
            let fetchRequest = try context.fetch(MonthCoreData.fetchRequest())
            let monthlyArray = fetchRequest as! [MonthCoreData]
            if monthlyArray.count == 0 {
                print("No Month in CoreData")
            }
            return monthlyArray
        } catch {
            print("Loading Month failed")
            return nil
        }
    }
    
    private func getAllPending() -> [CKPending]? {
        do {
            let fetchRequest = try context.fetch(CKPending.fetchRequest())
            let pendingArray = (fetchRequest as! [CKPending]).sorted { (s1, s2) -> Bool in
                s2.date! > s1.date!
            }
            if pendingArray.count == 0 {
                print("No CKPending in CoreData")
            }
            return pendingArray
        } catch {
            print("Loading CKPending failed")
            return nil
        }
    }

    func saveData() {
        do { try context.save() }
        catch { print("Saving CoreData failed: \(error)") }
    }
    

    
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





