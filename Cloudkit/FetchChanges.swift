//
//  FetchChanges.swift
//  goldbac
//
//  Created by adulphan youngmod on 7/8/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation
import CloudKit
//import CoreData

extension Cloudkit {

    func fetchChanges() {
        let now = Date()
        var predicate = NSPredicate()
        
        if let lastFetchDate = UserDefaults.standard.value(forKey: self.lastFetchUserDefaultKey) {
            predicate = NSPredicate(format: "modificationDate > %@", lastFetchDate as! NSDate)
        } else {
            predicate = NSPredicate(format: "TRUEPREDICATE")
        }

        let query = CKQuery(recordType: "Account", predicate: predicate)
        
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            print(records?.count.description ?? "No Record")
            Cloudkit.shared.isActive = false
            guard let newRecords = records else {return}
            self.updateAccountCoreDataWith(newRecords: newRecords)
            print("record Updated")
            UserDefaults.standard.set(now, forKey: self.lastFetchUserDefaultKey)
            Cloudkit.shared.isActive = true
            
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }
    }
    
    private func updateAccountCoreDataWith(newRecords: [CKRecord]) {
        for record in newRecords {

            let existingData = (CoreData.shared.allAccountsInCoreData!).filter { (coreData) -> Bool in
                coreData.recordID == record.recordID.recordName
            }
            
            if let existing = existingData.first {
                existing.recordID = record.recordID.recordName
                existing.modified = record.modificationDate
                existing.beginBalance = record.value(forKey: "beginBalance") as! Double
                existing.endBalance = record.value(forKey: "endBalance") as! Double
                existing.imageRecordID = record.value(forKey: "imageRecordID") as? String
                existing.name = record.value(forKey: "name") as? String
                existing.type = record.value(forKey: "type") as! Int16
                print("\(existing.recordID?.description ?? "No ID") : is updated")
            } else {
                let newAccount = AccountCoreData(context: CoreData.shared.context)
                newAccount.recordID = record.recordID.recordName
                newAccount.modified = record.modificationDate
                newAccount.beginBalance = record.value(forKey: "beginBalance") as! Double
                newAccount.endBalance = record.value(forKey: "endBalance") as! Double
                newAccount.imageRecordID = record.value(forKey: "imageRecordID") as? String
                newAccount.name = record.value(forKey: "name") as? String
                newAccount.type = record.value(forKey: "type") as! Int16
                print("\(newAccount.recordID?.description ?? "No ID") : is inserted")
            }

        }
        
        CoreData.shared.saveData()
    }

}








