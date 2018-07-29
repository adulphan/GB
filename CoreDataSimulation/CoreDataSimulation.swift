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
        var number:Double = 0
        for flow in CoreData.main.allFlowsInCoreData! {
            //print("\(flow.monthEnd): \(flow.account.name): \(flow.number)")
            number += flow.number
        }
        print("Total: \(number)")
        let time5 = Date().timeIntervalSince1970*multiplier
        
        print("Total transactions: \(CoreData.main.allTransactionsInCoreData?.count ?? 999)")
        print("Total accounts: \(CoreData.main.allAccountsInCoreData?.count ?? 999)")
        print("Time to clear data: \(time2-time)")
        print("Time to simulate accounts: \(time3-time2)")
        print("Time to simulate transactions: \(time4-time3)")
        print("Time to print flows: \(time5-time4)")
        
        CoreDataSimulation.main.printAllAccounts()
        
        let account = accountsDictionary["citi"]
        let transactionArray = account?.transactionArray
        var totalMoney:Double = 0
        var totalMonthlyFlow:Double = 0
        for transaction in transactionArray! {
            
            let index = transaction.accounts.index(of: account!)
            let money = transaction.moneyArray[index]
            totalMoney += money
            //printSequenceOf(contents: [transaction.date.description, money.description])
 
        }
        
        let flowArray = account?.flowArray
        for flow in flowArray! {
            totalMonthlyFlow += flow.number
            //printSequenceOf(contents: [flow.monthEnd.description, flow.number.description])
            
        }
        
        print("Tatal in transactions \(totalMoney)")
        print("Total in monthly flows: \(totalMonthlyFlow)")
        
        
    }

}







