//
//  Account+CoreDataClass.swift
//  goldbac
//
//  Created by adulphan youngmod on 24/7/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//
//

import Foundation
import CoreData

extension Account {
    
    var moneyArray: [Double] {
        get{
            return getMoneyArray()
        }
    }
    
    private var transactionArray: [Transaction] {
        get{
            return getTransactionArray()
        }
    }
    
    private func getTransactionArray() -> [Transaction] {
        let orderedSet = self.transactions as! NSMutableOrderedSet
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        orderedSet.sort(using: [sortDescriptor])
        let transactionArray = orderedSet.array as! [Transaction]
        return transactionArray
    }
    
    private func getMoneyArray() -> [Double] {
        var array: [Double] = []
        let tArray = transactionArray
        for transaction in tArray {
            let accounts = transaction.accounts.array as! [Account]
            let index = accounts.index(of: self)!
            let money = transaction.moneyArray[index]
            array.append(money)
        }
        return array
    }
    
    private func getOpositeAccounts() -> [[Account]] {
        
        var array: [[Account]] = []
        let tArray = transactionArray
        for transaction in tArray {
            let fromAccounts = transaction.fromAccounts
            if fromAccounts.contains(self) {
                let opposite = transaction.toAccounts
                array.append(opposite)
            } else {
                let opposite = transaction.fromAccounts
                array.append(opposite)
            }
        }
        return array
    }
    

}
