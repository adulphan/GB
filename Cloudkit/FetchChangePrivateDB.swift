//
//  FetchChangePrivateDB.swift
//  goldbac
//
//  Created by adulphan youngmod on 9/8/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation
import CloudKit
import CoreData

extension Cloudkit {


    func fetchChanges(in databaseScope: CKDatabaseScope, completion: @escaping () -> Void) {
        switch databaseScope {
        case .private:
            fetchDatabaseChanges(database: database, databaseTokenKey: "private", completion: completion)
        case .shared:
            //fetchDatabaseChanges(database: self.sharedDB, databaseTokenKey: "shared", completion: completion)
            fatalError()
        case .public:
            fatalError()
        }
    }

    func fetchDatabaseChanges(database: CKDatabase, databaseTokenKey: String, completion: @escaping () -> Void) {
        var changedZoneIDs: [CKRecordZoneID] = []
        
        let changeToken = UserDefaults.standard.databaseChangeToken
        
        let operation = CKFetchDatabaseChangesOperation(previousServerChangeToken: changeToken)
        
        operation.recordZoneWithIDChangedBlock = { (zoneID) in
            changedZoneIDs.append(zoneID)
        }
        
        operation.recordZoneWithIDWasDeletedBlock = { (zoneID) in
            // Write this zone deletion to memory
        }

        operation.changeTokenUpdatedBlock = { (token) in
            // Flush zone deletions for this database to disk
            // Write this new database change token to memory

            UserDefaults.standard.databaseChangeToken = token
            print("From changeTokenUpdatedBlock : \(token)")
            
        }
        
        operation.fetchDatabaseChangesCompletionBlock = { (token, moreComing, error) in
            if let error = error {
                print("Error during fetch shared database changes operation", error)
                completion()
                return
            }
            // Flush zone deletions for this database to disk
            // Write this new database change token to memory

            
            
            UserDefaults.standard.databaseChangeToken = token
            print("From fetchDatabaseChangesCompletionBlock : \(token?.description ?? "No Token")")
            
            self.fetchZoneChanges(database: database, databaseTokenKey: databaseTokenKey, zoneIDs: changedZoneIDs) {
                 //Flush in-memory database change token to disk
                completion()
            }
        }

        operation.qualityOfService = .userInitiated
        
        database.add(operation)
    }

    
    
    
    func fetchZoneChanges(database: CKDatabase, databaseTokenKey: String, zoneIDs: [CKRecordZoneID], completion: @escaping () -> Void) {
        
        // Look up the previous change token for each zone
        var optionsByRecordZoneID = [CKRecordZoneID: CKFetchRecordZoneChangesOptions]()
        for zoneID in zoneIDs {
            let options = CKFetchRecordZoneChangesOptions()
            options.previousServerChangeToken = UserDefaults.standard.zoneChangeToken
                optionsByRecordZoneID[zoneID] = options
        }
        let operation = CKFetchRecordZoneChangesOperation(recordZoneIDs: zoneIDs, optionsByRecordZoneID: optionsByRecordZoneID)
        
        operation.recordChangedBlock = { (record) in
            
            let fetchRequest: NSFetchRequest<AccountCoreData> = AccountCoreData.fetchRequest()
            let predicate = NSPredicate(format: "recordID == %@", record.recordID.recordName)
            fetchRequest.predicate = predicate
            
            do {
                if let account = try CoreData.shared.context.fetch(fetchRequest).first {
                    account.endBalance = (record.value(forKey: "endBalance") as? Double) ?? 0
        
                    account.imageRecordID = record.value(forKey: "imageRecordID") as? String
                    account.modified = record.modificationDate
                    account.name = record.value(forKey: "name") as? String
                    account.type = (record.value(forKey: "type") as? Int16) ?? 0
                } else {
                    let account = Account(record: record)
                    account?.addToCoreData(recordID: record.recordID.recordName)
                    
                }

            } catch  {
                print(error)
            }
            
            print("Record changed:", record.recordID.recordName)

        }
        
        operation.recordWithIDWasDeletedBlock = { (recordId, text) in
            
            let fetchRequest: NSFetchRequest<AccountCoreData> = AccountCoreData.fetchRequest()
            let predicate = NSPredicate(format: "recordID == %@", recordId.recordName)
            fetchRequest.predicate = predicate
            
            do {
                if let account = try CoreData.shared.context.fetch(fetchRequest).first {
                    CoreData.shared.context.delete(account)
                    print("Record deleted:", recordId.recordName)
                    print(text)
                }
            } catch  {
                print(error)
            }
            
            //let account = try context.fetch(fetchRequest)
//            let sortDescriptor = NSSortDescriptor(key: "modified", ascending: false)
//            fetchRequest.sortDescriptors = [sortDescriptor]
            

   
        }
        
        operation.recordZoneChangeTokensUpdatedBlock = { (zoneId, token, data) in
            // Flush record changes and deletions for this zone to disk
            // Write this new zone change token to disk
            UserDefaults.standard.zoneChangeToken = token
            print("From recordZoneChangeTokensUpdatedBlock : \(token?.description ?? "No Token")")
        }
        
        operation.recordZoneFetchCompletionBlock = { (zoneId, changeToken, _, _, error) in
            if let error = error {
                print("Error fetching zone changes for \(databaseTokenKey) database:", error)
                return
            }
        
            // Flush record changes and deletions for this zone to disk
            // Write this new zone change token to disk
            UserDefaults.standard.zoneChangeToken = changeToken
            print("From recordZoneFetchCompletionBlock : \(changeToken?.description ?? "No Token")")
        }
        
        operation.fetchRecordZoneChangesCompletionBlock = { (error) in
            if let error = error {
                print("Error fetching zone changes for \(databaseTokenKey) database:", error)
            }
            completion()
        }
        
        database.add(operation)
    }
    
    
    
    
    
    
    
    
    
    
}
