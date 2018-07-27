//
//  SimulateChangeTransaction.swift
//  goldbac
//
//  Created by adulphan youngmod on 27/7/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation
import UIKit

extension CoreDataSimulation {

    func simulateEditTransaction() {
        
        allTransactions = CoreData.main.allTransactionsInCoreData!
        let transaction = allTransactions[randomInt(min: 0, max: allTransactions.count-1)]
        transaction.moneyArray = transaction.moneyArray.map{$0*1.2}
        print("edtited: \(transaction.recordID)")
        
        let transaction_2 = allTransactions[randomInt(min: 0, max: allTransactions.count-1)]
        transaction_2.date = DateFormat.main.standardized(date: Date())
        
        print("edtited: \(transaction.recordID)")
        
        CoreData.main.saveData()
        
    }
    
    func simulateDeleteTransaction() {
        
        allTransactions = CoreData.main.allTransactionsInCoreData!
        let transaction = allTransactions[randomInt(min: 0, max: allTransactions.count-1)]

        CoreData.main.delete(transaction: transaction)
        
        print("deleted: \(transaction.recordID)")
        CoreData.main.saveData()
    }
    
    func simulateAddTransaction() {
        
        allTransactions = CoreData.main.allTransactionsInCoreData!
        let transaction = allTransactions[randomInt(min: 0, max: allTransactions.count-1)]
        
        let newTransaction = Transaction(context: CoreData.main.context)
        newTransaction.title = transaction.title
        
        newTransaction.recordID = UUID().uuidString
        newTransaction.accounts = transaction.accounts
        newTransaction.moneyArray = transaction.moneyArray
        print("added: \(transaction.recordID)")
        CoreData.main.saveData()
    }


}






