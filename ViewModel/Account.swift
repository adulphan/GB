//
//  Account.swift
//  goldbac
//
//  Created by adulphan youngmod on 2/8/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation
import UIKit


class Account {
    
    var transactions: [Transaction] {
        get { return getTransactionArray() }
    }

    var beginBalance: Double?
    var imageRecordID: String?
    var name: String?
    var type: Int16?
    var referenceAccount: AccountCoreData? {
        get{ return accountCoreData }
    }
    
    private var accountCoreData: AccountCoreData?
    
    func addToCoreData() {
        let account = AccountCoreData(context: CoreData.app.context)
        account.recordID = UUID().uuidString
        account.beginBalance = beginBalance!
        account.imageRecordID = imageRecordID
        account.name = name
        account.type = type!
    }
    
    func overwriteCoreData() {
        let account = accountCoreData!
        account.beginBalance = beginBalance!
        account.imageRecordID = imageRecordID
        account.name = name
        account.type = type!
    }
    
    func deleteCoreData() {
        let account = accountCoreData!
        CoreData.app.context.delete(account)
        CoreData.app.saveData()
        
        accountCoreData = nil
        beginBalance = nil
        imageRecordID = nil
        name = nil
        type = nil
    }
    
    
    func referenceTo(coreData: AccountCoreData) {
        accountCoreData = coreData
        beginBalance = coreData.beginBalance
        imageRecordID = coreData.imageRecordID
        name = coreData.name
        type = coreData.type
    }
    
    private func getTransactionArray() -> [Transaction] {
        guard let coreData = accountCoreData else { return [] }
        var transactionArray:[Transaction] = []
        if let transactionsForAccount = coreData.transactions {
            var transactionCoreData = transactionsForAccount.array as! [TransactionCoreData]
            transactionCoreData.sort { (t1, t2) -> Bool in
                t1.date! > t2.date!
            }
            for data in transactionCoreData {
                let transaction = Transaction()
                transaction.referenceTo(coreData: data)
                transactionArray.append(transaction)
            }
        }
        return transactionArray
    }
    
}













