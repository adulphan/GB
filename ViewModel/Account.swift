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
        CoreData.app.saveData()
    }
    
    func overwriteCoreData() {
        let account = accountCoreData!
        account.beginBalance = beginBalance!
        account.imageRecordID = imageRecordID
        account.name = name
        account.type = type!
        CoreData.app.saveData()
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


class Transaction {
    
    private var transactionCoreData:TransactionCoreData?
    
    var date: Date?
    var fullImageRecordID: String?
    var modified: Date?
    var moneyArray: [Double]?
    var note: String?
    var thumbnailRecordID: String?
    var title: String?
    var url: String?
    
    var accounts: [Account] {
        get{ return getAccountArray() }
    }
    
    func addToCoreData() {
        let transaction = TransactionCoreData(context: CoreData.app.context)
        transaction.recordID = UUID().uuidString
        transaction.date = date
        transaction.fullImageRecordID = fullImageRecordID
        transaction.modified = modified
        transaction.moneyArray = moneyArray
        transaction.note = note
        transaction.thumbnailRecordID = thumbnailRecordID
        transaction.title = title
        transaction.url = url
        CoreData.app.saveData()
    }
    
    func overwriteCoreData() {
        let transaction = transactionCoreData!
        transaction.date = date
        transaction.fullImageRecordID = fullImageRecordID
        transaction.modified = modified
        transaction.moneyArray = moneyArray
        transaction.note = note
        transaction.thumbnailRecordID = thumbnailRecordID
        transaction.title = title
        transaction.url = url
        CoreData.app.saveData()
    }
    
    func deleteCoreData() {
        let transaction = transactionCoreData!
        CoreData.app.context.delete(transaction)
        CoreData.app.saveData()
        transaction.date = nil
        
        transaction.fullImageRecordID = nil
        transaction.modified = nil
        transaction.moneyArray = nil
        transaction.note = nil
        transaction.thumbnailRecordID = nil
        transaction.title = nil
        transaction.url = nil
    }
    
    func referenceTo(coreData: TransactionCoreData) {
        transactionCoreData = coreData
        date = coreData.date
        fullImageRecordID = coreData.fullImageRecordID
        modified = coreData.modified
        moneyArray = coreData.moneyArray
        note = coreData.note
        thumbnailRecordID = coreData.thumbnailRecordID
        title = coreData.title
        url = coreData.url
        
    }

    private func getAccountArray() -> [Account] {
        guard let coreData = transactionCoreData else { return [] }
        var accountArray:[Account] = []
        if let accountsForTransaction = coreData.accounts {
            let accountCoreData = accountsForTransaction.array as! [AccountCoreData]
            for data in accountCoreData {
                let account = Account()
                account.referenceTo(coreData: data)
                accountArray.append(account)
            }
        }
        return accountArray
    }
    
}


class Statement {
    
    var endDate:Date
    var balance: Double
    var flow: Double
    
    init(statementCoreData: StatementCoreData) {
        
        endDate = statementCoreData.endDate!
        balance = statementCoreData.balance
        flow = statementCoreData.flow
        
        
    }
    
}








