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
    
    func saveToCloudKit(account:AccountCoreData) {
        let recordName = account.recordID!
        let recordID = CKRecordID(recordName: recordName)
        let newRecord = CKRecord(recordType: recordType.account.rawValue, recordID: recordID)
        
        newRecord.setObject(account.name! as CKRecordValue, forKey: "name")
        newRecord.setObject(account.type as CKRecordValue, forKey: "type")
        newRecord.setObject(account.beginBalance as CKRecordValue, forKey: "beginBalance")
        newRecord.setObject(account.endBalance as CKRecordValue, forKey: "endBalance")

        CKContainer.default().publicCloudDatabase.save(newRecord, completionHandler: { (record, error) in
            if error != nil {
                print(error!)
            } else {
                print("Account: \(recordID.recordName) is saved to CloudKit")
            }
        })
    }
    
    func deleteFromCloudKit(account:AccountCoreData) {
        let recordName = account.recordID!
        let recordID = CKRecordID(recordName: recordName)
        
        CKContainer.default().publicCloudDatabase.delete(withRecordID: recordID) { (recordID, error) in
            if error != nil {
                print(error!)
            } else {
                print("Account: \(recordID?.recordName ?? "No recordName") is deleted from CloudKit")
            }
        }
        
    }
    
    
}







