//
//  CloudKit.swift
//  goldbac
//
//  Created by adulphan youngmod on 5/8/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import CloudKit

class Cloudkit {
    
    static let shared = Cloudkit()
    
    enum recordType : String {
        case account = "Account"
        case transaction = "Transaction"
    }
    
    
    func deleteFromCloudkit(record: CKRecord, pending:Bool, completion: @escaping (CKRecordID?) -> ()) {
        
        guard Reachability.shared.isReachable else {
            if !pending {
                let pending = CKPending(context: CoreData.shared.context)
                pending.date = Date()
                pending.record = record
                pending.toDelete = true
                CoreData.shared.saveData()
            }
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


    func saveToCloudkit(record: CKRecord, pending:Bool, completion: @escaping (CKRecord?) -> ()) {
        
        guard Reachability.shared.isReachable else {
            if !pending {
                let pending = CKPending(context: CoreData.shared.context)
                pending.date = Date()
                pending.record = record
                pending.toDelete = false
                CoreData.shared.saveData()
            }
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
        
        saveToCloudkit(record: newRecord, pending:false) { (record) in
            print("Account: \(recordID.recordName) is saved to CloudKit")
        }
        
    }
    
    func deleteFromCloudKit(account:AccountCoreData) {
        let recordName = account.recordID!
        let recordID = CKRecordID(recordName: recordName)
        let record = CKRecord(recordType: recordType.account.rawValue, recordID: recordID)
        
        deleteFromCloudkit(record: record, pending: false) { (recordID) in
            print("Account: \(recordID?.recordName ?? "No record ID") is deleted from CloudKit")
        }

    }
    
    
}







