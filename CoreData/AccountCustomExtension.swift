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
    
    var monthlyArray: [Monthly] { get{return getMonthlyArray()}}
    var transactionArray: [Transaction] {get{return getTransactionArray()}}
    
    private func getMonthlyArray() -> [Monthly] {

        let flowArray = self.monthly?.array as! [Monthly]
        return flowArray
    }
    
    private func getTransactionArray() -> [Transaction] {
        let orderedSet = self.transactions as! NSMutableOrderedSet
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        orderedSet.sort(using: [sortDescriptor])
        let transactionArray = orderedSet.array as! [Transaction]
        return transactionArray
    }
    

}
