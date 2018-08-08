//
//  Transaction.swift
//  goldbac
//
//  Created by adulphan youngmod on 3/8/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation
import UIKit


class Transaction {
    
    private var transactionCoreData:TransactionCoreData?
    
    var date: Date?
    var fullImageRecordID: String?
    var modified: Date?
    var flowArray: [Double]?
    var note: String?
    var thumbnailRecordID: String?
    var title: String?
    var url: String?
    
    var referenceTransaction: TransactionCoreData? {
        get { return transactionCoreData }
    }
    
    var accounts: [Account]?
    
    func addToCoreData() {
        let transaction = TransactionCoreData(context: CoreData.shared.context)
        transaction.recordID = UUID().uuidString
        transaction.date = date
        transaction.fullImageRecordID = fullImageRecordID
        transaction.modified = modified
        transaction.flowArray = flowArray
        transaction.note = note
        transaction.thumbnailRecordID = thumbnailRecordID
        transaction.title = title
        transaction.url = url
        transaction.accounts = getAccountCoreData()

    }
    
    func overwriteCoreData() {
        let transaction = transactionCoreData!
        transaction.date = date
        transaction.fullImageRecordID = fullImageRecordID
        transaction.modified = modified
        transaction.flowArray = flowArray
        transaction.note = note
        transaction.thumbnailRecordID = thumbnailRecordID
        transaction.title = title
        transaction.url = url
        transaction.accounts = getAccountCoreData()
    }
    
    func deleteCoreData() {
        let transaction = transactionCoreData!
        CoreData.shared.context.delete(transaction)
        CoreData.shared.saveData()
        transaction.date = nil
        
        transaction.fullImageRecordID = nil
        transaction.modified = nil
        transaction.flowArray = nil
        transaction.note = nil
        transaction.thumbnailRecordID = nil
        transaction.title = nil
        transaction.url = nil
        transaction.accounts = nil
    }
    
    func referenceTo(coreData: TransactionCoreData) {
        transactionCoreData = coreData
        date = coreData.date
        fullImageRecordID = coreData.fullImageRecordID
        modified = coreData.modified
        flowArray = coreData.flowArray
        note = coreData.note
        thumbnailRecordID = coreData.thumbnailRecordID
        title = coreData.title
        url = coreData.url
        
        accounts = getAccountArray()
        
    }
    
    private func getAccountCoreData() -> NSOrderedSet {
        guard let array = accounts else { return [] }
        var outputArray:[AccountCoreData] = []
        for account in array {
            guard let reference = account.referenceAccount else { return [] }
            outputArray.append(reference)
        }
        return NSOrderedSet(array: outputArray)
    }
    
    private func getAccountArray() -> [Account] {
        guard let coreData = transactionCoreData else { return [] }
        var accountArray:[Account] = []
        if let accountsForTransaction = coreData.accounts {
            let accountCoreData = accountsForTransaction.array as! [AccountCoreData]
            for data in accountCoreData {
                let account = Account(coreData: data)!
                accountArray.append(account)
            }
        }
        return accountArray
    }
    
//    func getFlowOf(account: Account) -> Double? {
//        guard let array = self.accounts else {return nil}
//
//        let index = array.index
//        guard let flows = self.flowArray else {return nil}
//        if let i = index {
//            return flows[i]
//        } else {
//            return nil
//        }
//    }
}
