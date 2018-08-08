//
//  Account.swift
//  goldbac
//
//  Created by adulphan youngmod on 2/8/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation
import UIKit
import CloudKit


class Account {
    
    var transactions: [Transaction] {
        get { return getTransactionArray() }
    }

    var recordID: String?
    var beginBalance: Double?
    var endBalance: Double?
    var imageRecordID: String?
    var modified: Date?
    var name: String?
    var type: Int16?
    var referenceAccount: AccountCoreData? {
        get{ return accountCoreData }
    }
    
    init?(coreData: AccountCoreData) {
        accountCoreData = coreData
        recordID = coreData.recordID
        beginBalance = coreData.beginBalance
        endBalance = coreData.endBalance
        imageRecordID = coreData.imageRecordID
        modified = coreData.modified
        name = coreData.name
        type = coreData.type
    }
    
    init?(record: CKRecord) {

        recordID = record.recordID.recordName
        beginBalance = record.value(forKey: "beginBalance") as? Double
        endBalance = record.value(forKey: "endBalance") as? Double
        imageRecordID = record.value(forKey: "imageRecordID") as? String
        modified = record.modificationDate
        name = record.value(forKey: "name") as? String
        type = record.value(forKey: "type") as? Int16
    }
    
    init() {
        
    }
    
    private var accountCoreData: AccountCoreData?
    
    func addToCoreData() {
        let account = AccountCoreData(context: CoreData.shared.context)
        account.recordID = UUID().uuidString
        account.beginBalance = beginBalance!
        account.endBalance = beginBalance!
        account.imageRecordID = imageRecordID
        account.name = name
        account.type = type!
    }
    
    func overwriteCoreData() {
        let account = accountCoreData!
        account.beginBalance = beginBalance!
        account.endBalance = beginBalance!
        account.imageRecordID = imageRecordID
        account.name = name
        account.type = type!
    }
    
    func deleteCoreData() {
        let account = accountCoreData!
        CoreData.shared.context.delete(account)
        CoreData.shared.saveData()
        
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













