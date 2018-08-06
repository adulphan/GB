//
//  ProceedPending.swift
//  goldbac
//
//  Created by adulphan youngmod on 6/8/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation
import CloudKit


extension Cloudkit {
    
    func proceedPendingsToCloudKit() {
        
        guard let allPendings = CoreData.shared.allPending else {
            print("Fetching CKPendings fails")
            return
        }        
        guard allPendings.count != 0 else { return }
        
        let savePending = allPendings.filter { (pending) -> Bool in
            pending.toDelete == false
            }
        
        let deletePending = allPendings.filter { (pending) -> Bool in
            pending.toDelete == true
        }
        
        let recordToSave = savePending.map{$0.record!}
        let recordIDsToDelete = deletePending.map{($0.record?.recordID)!}
        
        let saveOperation = CKModifyRecordsOperation(recordsToSave: recordToSave, recordIDsToDelete: nil)
        
        saveOperation.perRecordCompletionBlock = {( record, error) in
            if error != nil {
                print(error!)
            } else {
                print("\(record.recordID.recordName) is saved")
            }
        }
        
        saveOperation.modifyRecordsCompletionBlock = { (savedRecords, deletedRecordIDs, error) in
            if error != nil {
                print(error!)
            } else {
                print("saveOperation finished : \(savedRecords?.count ?? 0) records saved")
                for pending in savePending {
                    CoreData.shared.context.delete(pending)
                }
            }
        }
        
        CKContainer.default().publicCloudDatabase.add(saveOperation)
        
        let deleteOperation = CKModifyRecordsOperation(recordsToSave: nil, recordIDsToDelete: recordIDsToDelete)
        
        deleteOperation.perRecordCompletionBlock = {( record, error) in
            if error != nil {
                print(error!)
            } else {
                print("\(record.recordID.recordName) is deleted")
            }
        }
        
        deleteOperation.modifyRecordsCompletionBlock = { (savedRecords, deletedRecordIDs, error) in
            if error != nil {
                print(error!)
            } else {
                print("deleteOperation finished : \(deletedRecordIDs?.count ?? 0) records deleted")
                for pending in deletePending {
                    CoreData.shared.context.delete(pending)
                }
            }
        }
        deleteOperation.addDependency(saveOperation)
        CKContainer.default().publicCloudDatabase.add(deleteOperation)
    }
}







