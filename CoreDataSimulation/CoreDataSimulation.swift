//
//  CoreDataSimulation.swift
//  goldbac
//
//  Created by adulphan youngmod on 26/7/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataSimulation {
    
    static let main = CoreDataSimulation()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let components = Calendar.current.dateComponents([.day,.month,.year], from: Date())
    var allAccounts: [Account] = []
    var allTransactions: [Transaction] = []
    var isSimulating:Bool = false
    var accountsDictionary:[String:Account] = [:]
}

extension CoreDataSimulation {
    
    func simulateData() {
        let multiplier:Double = 1
        let time = Date().timeIntervalSince1970*multiplier
        CoreData.main.clearAllCoreData()
        let time2 = Date().timeIntervalSince1970*multiplier
        CoreDataSimulation.main.simulateAccounts()
        let time3 = Date().timeIntervalSince1970*multiplier
        CoreDataSimulation.main.simulateTransaction()
        let time4 = Date().timeIntervalSince1970*multiplier
        print("Total flow: \(CoreData.main.allFlowsInCoreData?.count ?? 9999)")
        
        print("Total transactions: \(CoreData.main.allTransactionsInCoreData?.count ?? 999)")
        print("Total accounts: \(CoreData.main.allAccountsInCoreData?.count ?? 999)")
        print("Time to clear data: \(time2-time)")
        print("Time to simulate accounts: \(time3-time2)")
        print("Time to simulate transactions: \(time4-time3)")

        checkBalanceWithTransactionMoney()

    }

    func checkBalanceWithTransactionMoney() {
        
        for account in CoreData.main.allAccountsInCoreData! {

            let transactionArray = account.transactionArray
            var totalAmount:Double = 0
            for transaction in transactionArray {
                let index = (transaction.accounts.array as! [Account]).index(of: account)
                let money = transaction.moneyArray[index!]
                totalAmount += money
            }

            let balance = account.flowArray.count == 0 ?  account.beginBalance : account.flowArray.first?.number
            
            if balance?.rounded() != totalAmount.rounded() {
                print("Eror: Balance mismatched:")
                printSequenceOf(contents: ["\(account.name)","\(balance!)","\(totalAmount + account.beginBalance)", "\(account.beginBalance)"])
            }
        }

    }
    
    func printAllTransactionsFor(account: Account) {
        
        let transactionArray = account.transactionArray
        for transaction in transactionArray {
            let index = (transaction.accounts.array as! [Account]).index(of: account)
            let money = transaction.moneyArray[index!]
            
            printSequenceOf(contents: ["\(transaction.date)","\(money)"])
        }

    }
    
    func printAllFlowsFor(account: Account) {
        
        let flowArray = account.flowArray
        for flow in flowArray {
            
            printSequenceOf(contents: ["\(flow.monthEnd)","\(flow.number)"])
        }
        
    }
    
}







