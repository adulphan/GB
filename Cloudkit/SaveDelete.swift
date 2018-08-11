//
//  SaveDeleteCK.swift
//  goldbac
//
//  Created by adulphan youngmod on 6/8/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation
import CloudKit
import AVFoundation

extension Cloudkit {

    func deleteFromCloudkit(record: CKRecord, completion: @escaping (CKRecordID?) -> ()) {

        database.delete(withRecordID: record.recordID, completionHandler: { (recordID, error) in
            if error != nil {
                print(error!)
            } else {
                completion(recordID)                
            }
        })

    }
    
    
    func saveToCloudkit(record: CKRecord, completion: @escaping (CKRecord?) -> ()) {
        database.save(record, completionHandler: { (record, error) in
            if error != nil {
                print(error!)
            } else {
                completion(record)
            }
        })
    }
    
    func saveToCloudKit(account:AccountCoreData) {
        let recordName = account.recordID!
        let recordID = CKRecordID(recordName: recordName, zoneID: personalZoneID)
        let newRecord = CKRecord(recordType: recordType.account.rawValue, recordID: recordID)
        
        newRecord.setObject((account.name ?? "No name") as CKRecordValue, forKey: "name")
        newRecord.setObject(account.type as CKRecordValue, forKey: "type")
        newRecord.setObject(account.beginBalance as CKRecordValue, forKey: "beginBalance")
        newRecord.setObject(account.endBalance as CKRecordValue, forKey: "endBalance")
        
        saveToCloudkit(record: newRecord) { (record) in
            print("Account: \(recordID.recordName) is saved to CloudKit")
            let systemSoundID: SystemSoundID = 1001
            AudioServicesPlaySystemSound (systemSoundID)
        }
        
    }
    
    func saveEditedRecordToCloudKit(account:AccountCoreData) {
        let recordName = account.recordID!
        let recordID = CKRecordID(recordName: recordName, zoneID: personalZoneID)
        
        database.fetch(withRecordID: recordID) { (record, error) in
            if error != nil {
                print(error!)
            } else {
                
                record?.setObject(account.name! as CKRecordValue, forKey: "name")
                record?.setObject(account.type as CKRecordValue, forKey: "type")
                record?.setObject(account.beginBalance as CKRecordValue, forKey: "beginBalance")
                record?.setObject(account.endBalance as CKRecordValue, forKey: "endBalance")
                
                self.database.save(record!, completionHandler: { (record, error) in
                    if error != nil {
                        print(error!)
                    } else {
                        print("\(record?.recordID.recordName.description ?? "No ID") is saved")
                        
                    }
                })
                
//                
//                let saveOperation = CKModifyRecordsOperation(recordsToSave: [record!], recordIDsToDelete: nil)
//                saveOperation.savePolicy = .changedKeys
//
//                saveOperation.modifyRecordsCompletionBlock = { (savedRecords, deletedRecordIDs, error) in
//                    if error != nil {
//                        print(error!)
//                    } else {
//                        print("\(record?.recordID.recordName.description ?? "No ID") is saved")
//  
//                    }
//                }
//                
//                self.database.add(saveOperation)
            }
        }


        
    }
    
    func deleteFromCloudKit(account:AccountCoreData) {
        let recordName = account.recordID!
        let recordID = CKRecordID(recordName: recordName, zoneID: personalZoneID)
                
        database.delete(withRecordID: recordID, completionHandler: { (recordID, error) in
            if error != nil {
                print(error!)
            } else {

                print("Account: \(recordID?.recordName ?? "No record ID") is deleted from CloudKit")
                let systemSoundID: SystemSoundID = 1001
                AudioServicesPlaySystemSound (systemSoundID)
            }
        })
        

        
    }
    
    
}





//        guard Reachability.shared.isReachable else {
//            let pending = CKPending(context: CoreData.shared.context)
//            pending.date = Date()
//            pending.record = record
//            pending.toDelete = false
//            CoreData.shared.saveData()
//
//            print("No Internet connection, saving: \(record.recordID.recordName) is pending")
//            return
//        }






