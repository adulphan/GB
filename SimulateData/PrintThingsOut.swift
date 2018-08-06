//
//  PrintThingsOut.swift
//  goldbac
//
//  Created by adulphan youngmod on 4/8/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation
import UIKit
import CoreData


extension SimulateData {
    
    
    func printAllAccountsCoreData() {
        for account in CoreData.shared.allAccountsInCoreData! {
            print("\(account.name ?? "No name")")
        }
        print("Total accounts: \(CoreData.shared.allAccountsInCoreData?.count ?? 999999)")
        
    }
    
    func printAllTransactionsCoreData() {
        for transactionCD in CoreData.shared.allTransactionsInCoreData! {
            let transaction = Transaction()
            transaction.referenceTo(coreData: transactionCD)
            
            let accounts = transaction.accounts ?? []
            let accountNames = accounts.map{$0.name!}
            
            print("\(transaction.date!) : \(transaction.title ?? "No Title") : \(accountNames)")
        }
        
        print("Total transactions: \(CoreData.shared.allTransactionsInCoreData?.count ?? 999999)")
        
    }
    
    func printAllCKPendingInCoreData() {
        for pending in CoreData.shared.allPending! {
            print("\(pending.date!) : \(pending.toDelete ? "pendingDelete":"pendingSave") : \(pending.record?.recordID.recordName ?? "No record name")")
        }
        
        print("Total pending: \(CoreData.shared.allPending?.count ?? 999999)")
        
    }
    
    func printAllMonthsInCoreDataFor(account: AccountCoreData) {
        for month in account.monthlyData?.array as! [MonthCoreData] {
            print("\(month.endDate?.description ?? "No Date") Flow: \(month.flow) Balance: \(month.balance)")
        }
    }
    
    
    func printBalanceFor(monthEnd: Date) {
        
        var sumOfBalances:Double = 0
        for account in CoreData.shared.allAccountsInCoreData! {
            let array = account.monthlyData?.array as! [MonthCoreData]
            if let index = array.index(where: {$0.endDate! <= monthEnd}) {
                let month = array[index]
                print("\(account.name ?? "No name") balance: \(month.balance)")
                sumOfBalances += month.balance
            } else {
                print("\(account.name ?? "No name") balance: \(account.beginBalance)")
                sumOfBalances += account.beginBalance
            }
        }
        
        if sumOfBalances == 0 {
            print("Balanced correct!!")
        } else {
            print("NOT balanced, difference: \(sumOfBalances)")
        }
    }


}





