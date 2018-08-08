//
//  SaveDeleteCK.swift
//  goldbac
//
//  Created by adulphan youngmod on 6/8/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation
import CloudKit


extension Cloudkit {

    func deleteFromCloudkit(record: CKRecord, completion: @escaping (CKRecordID?) -> ()) {
        
        guard Reachability.shared.isReachable else {
            
            let pending = CKPending(context: CoreData.shared.context)
            pending.date = Date()
            pending.record = record
            pending.toDelete = true
            CoreData.shared.saveData()
            print("No Internet connection, deleting: \(record.recordID.recordName) is pending")
            return
        }
        
        CKContainer.default().publicCloudDatabase.delete(withRecordID: record.recordID, completionHandler: { (recordID, error) in
            if error != nil {
                print(error!)
            } else {
                completion(recordID)
            }
        })
    }
    
    
    func saveToCloudkit(record: CKRecord, completion: @escaping (CKRecord?) -> ()) {
        
        guard Reachability.shared.isReachable else {
            let pending = CKPending(context: CoreData.shared.context)
            pending.date = Date()
            pending.record = record
            pending.toDelete = false
            CoreData.shared.saveData()
            
            print("No Internet connection, saving: \(record.recordID.recordName) is pending")
            return
        }
        
        CKContainer.default().publicCloudDatabase.save(record, completionHandler: { (record, error) in
            if error != nil {
                print(error!)
            } else {
                completion(record)
            }
        })
    }
    
    func saveToCloudKit(account:AccountCoreData) {
        let recordName = account.recordID!
        let recordID = CKRecordID(recordName: recordName)
        let newRecord = CKRecord(recordType: recordType.account.rawValue, recordID: recordID)
        
        newRecord.setObject(account.name! as CKRecordValue, forKey: "name")
        newRecord.setObject(account.type as CKRecordValue, forKey: "type")
        newRecord.setObject(account.beginBalance as CKRecordValue, forKey: "beginBalance")
        newRecord.setObject(account.endBalance as CKRecordValue, forKey: "endBalance")
        
        saveToCloudkit(record: newRecord) { (record) in
            print("Account: \(recordID.recordName) is saved to CloudKit")
        }
        
    }
    
    func deleteFromCloudKit(account:AccountCoreData) {
        let recordName = account.recordID!
        let recordID = CKRecordID(recordName: recordName)
        let record = CKRecord(recordType: recordType.account.rawValue, recordID: recordID)
        
        deleteFromCloudkit(record: record) { (recordID) in
            print("Account: \(recordID?.recordName ?? "No record ID") is deleted from CloudKit")
        }
        
    }
    
    
}








