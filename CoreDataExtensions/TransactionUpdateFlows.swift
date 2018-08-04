//
//  TransactionCoreData.swift
//  goldbac
//
//  Created by adulphan youngmod on 3/8/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation
import CoreData

extension TransactionCoreData {
    
    func cacheThisCommittedTransaction() {
        let committedTransation = Transaction()
        committedTransation.referenceTo(coreData: self)
        cachedLastCommitted = committedTransation        
    }
    
    func deleteFlows() {
        if SimulateData.shared.isClearingData { return }
        guard let transaction = cachedLastCommitted else{return}
        updateBalanceWith(transaction: transaction, isDeleted: true)
    }
    
    func insertFlows() {
        let transaction = Transaction()
        transaction.referenceTo(coreData: self)
        updateBalanceWith(transaction: transaction, isDeleted: false)
    }
    
    func updateFlows() {
        guard let oldTransaction = cachedLastCommitted else{return}
        let updateTransaction = Transaction()
        updateTransaction.referenceTo(coreData: self)
        
        updateBalanceWith(transaction: oldTransaction, isDeleted: true)
        updateBalanceWith(transaction: updateTransaction, isDeleted: false)
    }
    
    func updateBalanceWith(transaction: Transaction, isDeleted: Bool) {
        
        guard let accounts = transaction.accounts else {return}
        let accountsCoreData = accounts.map{$0.referenceAccount!}
        let direction:Double = isDeleted ? -1:1
        let flowArray = transaction.flowArray!.map{$0*direction}
        let date = transaction.date!
        
        for i in 0...accountsCoreData.count-1 {
            
            let account = accountsCoreData[i]
            let flow = flowArray[i]
            let monthEnd = date.adjustedToAppCalendar.monthEnd
            
            let monthArray = account.monthlyData?.array as! [MonthCoreData]
            let withSameMonth = monthArray.filter { (month) -> Bool in
                month.endDate == monthEnd
            }
            
            if let thisMonth = withSameMonth.first {
                thisMonth.flow += flow
                thisMonth.balance += flow
                let index = monthArray.index(of: thisMonth)!
                if index != 0 {
                    for i in 0...index-1 {
                        (account.monthlyData?.object(at: i) as! MonthCoreData).balance += flow
                    }
                }
            }
            else {
                
                let newMonth = MonthCoreData(context: CoreData.shared.context)
                newMonth.endDate = monthEnd
                newMonth.flow = flow
                
                if let index = monthArray.index(where: {$0.endDate! < monthEnd}) {
                    newMonth.balance = monthArray[index].balance + flow
                    account.insertIntoMonthlyData(newMonth, at: index)
                    if index != 0 {
                        for i in 0...index-1 {
                            (account.monthlyData?.object(at: i) as! MonthCoreData).balance += flow
                        }
                    }
                    
                } else {
                    newMonth.balance = account.beginBalance + flow
                    account.addToMonthlyData(newMonth)
                    for object in account.monthlyData! {
                        let month = object as! MonthCoreData
                        if month != newMonth {
                            month.balance += flow
                        }
                    }

                }
            }
        }
    
    }
    
    func getFlowOf(account: AccountCoreData) -> Double? {
        guard let accounts = self.accounts else {return nil}
        let accountArray = accounts.array as! [AccountCoreData]
        let index = accountArray.index(of: account)
        guard let flows = self.flowArray else {return nil}
        if let i = index {
            return flows[i]
        } else {
            return nil
        }
    }
}




