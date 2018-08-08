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
            predicate = NSPredicate(format: "modifiedAt > %@", lastFetchDate as! NSDate)
        } else {
            predicate = NSPredicate(format: "TRUEPREDICATE")
        }

        let query = CKQuery(recordType: "Account", predicate: predicate)
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            print(records?.count.description ?? "No Record")
            UserDefaults.standard.set(now, forKey: self.lastFetchUserDefaultKey)
        }
    }
    
    private func updateAccountCoreDataWith(newRecords: [CKRecord]) {
        //for record in newRecords {
            
      //      let newAccount = Account()

        //}
    }

}








