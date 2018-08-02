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

        printTimeSpendEachProcess()
//        
//        printBalanceForAllAccounts()
        CoreDataSimulation.main.simulateEditTransaction()
        
        CoreData.main.saveData()
        
    }
    
    func printTimeSpendEachProcess() {
        
        let multiplier:Double = 1
        let time = Date().timeIntervalSince1970*multiplier
        CoreData.main.clearAllCoreData()
        let time2 = Date().timeIntervalSince1970*multiplier
        CoreDataSimulation.main.simulateAccounts()
        let time3 = Date().timeIntervalSince1970*multiplier
        CoreDataSimulation.main.simulateTransaction()
        let time4 = Date().timeIntervalSince1970*multiplier
        print("Total monthly: \(CoreData.main.allMonthlyInCoreData?.count ?? 9999)")
        print("Total transactions: \(CoreData.main.allTransactionsInCoreData?.count ?? 999)")
        print("Total accounts: \(CoreData.main.allAccountsInCoreData?.count ?? 999)")
        print("Time to clear data: \(time2-time)")
        print("Time to simulate accounts: \(time3-time2)")
        print("Time to simulate transactions: \(time4-time3)")
        
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

            let balance = account.monthly?.count == 0 ?  account.beginBalance : account.monthlyArray.first?.balance
            
            if balance?.rounded() != totalAmount.rounded() {
                print("Eror: Balance mismatched:")
                printSequenceOf(contents: ["\(account.name)","\(balance!)","\(totalAmount + account.beginBalance)", "\(account.beginBalance)"])
            }
        }

    }
    
    func testSpecifics() {
        
        let account = accountsDictionary["wallet"]!
        printAllMonthlyFor(account: account)
        let array = account.transactionArray
        let transaction = array[randomInt(min: 0, max: array.count-1)]
        
        
        print("\(transaction.date) : \(transaction.title ?? "No Title") : \((transaction.accounts.array as! [Account]).map{$0.name}) : \(transaction.moneyArray)")
        //CoreData.main.context.delete(transaction)
        
        //transaction.moneyArray = [-200,200]
        transaction.date = DateFormat.main.standardized(date: Date())
        transaction.removeFromAccounts(at: 1)
        transaction.addToAccounts(accountsDictionary["utility"]!)
        
        
        CoreData.main.saveData()
        print("\(transaction.date) : \(transaction.title ?? "No Title") : \((transaction.accounts.array as! [Account]).map{$0.name}) : \(transaction.moneyArray)")
        
        printAllMonthlyFor(account: account)

    }
    
    func printAllTransactionsFor(account: Account) {
        
        let transactionArray = account.transactionArray
        for transaction in transactionArray {
            let index = (transaction.accounts.array as! [Account]).index(of: account)
            let money = transaction.moneyArray[index!]
            
            printSequenceOf(contents: ["\(transaction.date)","\(money)"])
        }

    }
    
    func printAllMonthlyFor(account: Account) {
        
        let monthlyArray = account.monthlyArray
        for monthly in monthlyArray {
            
            printSequenceOf(contents: ["\(monthly.endDate)","FLow \(monthly.flow)","Balance \(monthly.balance)"])
        }

        print("Total flows: \(monthlyArray.map{$0.flow}.reduce(0,+))")
        
    }
    
    func printBalanceForAllAccounts() {
        
        for account in CoreData.main.allAccountsInCoreData! {
            
            if let monthy = account.monthlyArray.first {
                print("\(account.name) : \(monthy.balance)")
            } else {
                print("\(account.name) : \(account.beginBalance)")
            }
            
        }
        
    }
    
}







