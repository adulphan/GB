////
////  CloudKit.swift
////  Carrot
////
////  Created by adulphan youngmod on 20/7/18.
////  Copyright © 2018 Home Inc. All rights reserved.
////
//
//import CloudKit
//
//
//class CloudKit {
//    
//    static let sharedInstance = CloudKit()
//    
//    var transactionRecords:[CKRecord] = []
//    
//    func fetchAllTransactions() {
//        
//        let query = CKQuery(recordType: "Transaction", predicate: NSPredicate(format: "TRUEPREDICATE"))
//        
//        var operation = CKQueryOperation(query: query)
//        operation.queuePriority = .normal
//        operation.resultsLimit = 50
//        //queryOperation.desiredKeys = ["Koordinaatit"]
//        
//        
//        operation.recordFetchedBlock = { (record) -> Void in
//            self.transactionRecords.append(record)
//        }
//        
//        operation.queryCompletionBlock = { (cursor, error) -> Void in
//            
//            if error != nil {
//                print("Failed to get data")
//                return
//            }
//            
//            if cursor != nil {
//                let newOperation = CKQueryOperation(cursor: cursor!)
//                newOperation.cursor = cursor
//                newOperation.resultsLimit = operation.resultsLimit
//                newOperation.queryCompletionBlock = operation.queryCompletionBlock
//                operation = newOperation
//                CKContainer.default().publicCloudDatabase.add(operation)
//                return
//                
//            } else {
//                
//                print("Fetch Transactions Completed")
//                print(self.transactionRecords.count)
//                print(self.transactionRecords.first!)
//                
//            }
//
//        }
//        
//        CKContainer.default().publicCloudDatabase.add(operation)
//        
//        
//        
//    }
//    
//    private func saveTransactionsToCoredata(transactioRecord: CKRecord) {
//        
//        let context = ManageCoreData.sharedInstance.context
//        
//        let localTransaction = Transaction(context: context)
//        
//        if let photo = transactioRecord.object(forKey: "photo") as! CKAsset? {
//            let data = NSData(contentsOf: photo.fileURL)!
//            let fileName = UUID().uuidString + ".heic"
//            File.sharedInstance.saveImageToAppFolder(imageData: data as Data, fileName: fileName)
//            localTransaction.fullPhotoName = fileName
//            localTransaction.thumbName = fileName
//        }
//        
//        
//        localTransaction.title = transactioRecord.object(forKey: "title") as? String
//        localTransaction.date = transactioRecord.object(forKey: "date") as? Date
//        localTransaction.amount = transactioRecord.object(forKey: "totalAmount") as! Double
//        
//
//    }
//    
//    
//    func fetchAllPhoto() {
//        
//        let query = CKQuery(recordType: "Transaction", predicate: NSPredicate(format: "TRUEPREDICATE"))
//        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
//            
//            if error != nil {
//                
//                print(error!)
//                
//                return
//            }
//            
//            var totalStorage:Double = 0
//            
//            for record in records! {
//
//                if let photo = record.object(forKey: "photo") as! CKAsset? {
//                
//                    print(photo.fileURL)
//                    
//                    let data = NSData(contentsOf: photo.fileURL)
//
//                    let fileSize = File.sharedInstance.getFileSize(fromData: data! as Data)
//                    totalStorage += fileSize
//                }
//                
//                print(records?.index(of: record) ?? "No Index of record")
//            }
//            
//             let numberString = Format.sharedInstance.amountDisplay(amount: totalStorage).dropFirst()
//            print("Total assset storage: \(numberString) KB")
//
//        }
//        
//    }
//    
//    
//
//    func subscribeToPushNotification() {
//
//        let subscriptionID = "cloudkit-transaction-changes"
//        
//        //UserDefaults.standard.removeObject(forKey: subscriptionID)
//        
//        let subscriptionIsLocallyCached = UserDefaults.standard.bool(forKey: subscriptionID)
//        guard !subscriptionIsLocallyCached else {
//            return
//        }
//
//        let subscription = CKQuerySubscription(recordType: "Transaction", predicate: NSPredicate(format: "TRUEPREDICATE"), subscriptionID: subscriptionID, options: [.firesOnRecordCreation, .firesOnRecordDeletion, .firesOnRecordUpdate])
//        
//
//        let notificationInfo = CKNotificationInfo()
//        notificationInfo.alertBody = "Transaction changes"
//        notificationInfo.soundName = "default"
//        notificationInfo.shouldSendContentAvailable = true
//        subscription.notificationInfo = notificationInfo
//
//        CKContainer.default().publicCloudDatabase.save(subscription, completionHandler: { subscription, error in
//            if error == nil {
//                print("Subscription: \(subscription?.subscriptionID ?? "xxxxxx"), saved successfully")
//                UserDefaults.standard.set(true, forKey: subscriptionID)
//            } else {
//                print(error!)
//            }
//        })
//        
//    }
// 
//    func fetchUserID(complete: @escaping (_ instance: String?, _ error: Error?) -> ()) {
//        CKContainer.default().fetchUserRecordID() {
//            recordID, error in
//            if error != nil {
//                print(error!.localizedDescription)
//                complete(nil, error)
//            } else {
//                print("fetched ID: \(recordID?.recordName ?? "xxxxx")")
//                complete(recordID?.recordName, nil)
//            }
//        }
//    }
//    
//
//    func clearDataCloudkit(recordType: String) {
//        
//        let predicate = NSPredicate(value: true)
//        let query = CKQuery(recordType: recordType, predicate: predicate)
//        
//        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { (recordArray, error) in
//            
//            for record: CKRecord in recordArray! {
//                CKContainer.default().publicCloudDatabase.delete(withRecordID: record.recordID, completionHandler: { (id, error) in
//                    if error != nil {
//                        print(error ?? "00000")
//                    } else {
//                        print((id?.recordName)! + " is deleted")
//                    }
//                })
//            }
//        }
//
//    }
//
//    func saveToCloudKit(newTransaction:Transaction) {
//        
//        let newRecord = CKRecord(recordType: "Transaction")
//
//        if let name = newTransaction.fullPhotoName {
//            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//            let fileURL = documentsDirectory.appendingPathComponent(name)
//            let asset = CKAsset(fileURL: fileURL)
//            newRecord.setObject(asset, forKey: "photo")
//            
//        }
//        
//        if let title = newTransaction.title {
//            newRecord.setObject(title as CKRecordValue, forKey: "title")
//        }
//        
//        newRecord.setObject(newTransaction.amount as CKRecordValue, forKey: "totalAmount")
//        newRecord.setObject(newTransaction.date as CKRecordValue?, forKey: "date")
//        
//        let amountArray = (newTransaction.splitSet?.array as! [SplitBit]).map{$0.amount}
//        newRecord.setObject(amountArray as NSArray, forKey: "amountArray")
//        
//        let accountArray = (newTransaction.splitSet?.array as! [SplitBit]).map{$0.account?.name}
//        newRecord.setObject(accountArray as NSArray, forKey: "accountArray")
//        
//        CKContainer.default().publicCloudDatabase.save(newRecord, completionHandler: { (record, error) in
//            if error != nil {
//                print(error!)
//            } else {
//                print("\(String(describing: record?.recordID.recordName)) is saved")
//            }
//        })
//        
//        
//    }
//    
////    var databaseChangesTolken: CKServerChangeToken?
////    
////    func fetchDatabaseChanges(_ callBack: () -> Void) {
////        
////        let changesOperation = CKFetchDatabaseChangesOperation(previousServerChangeToken: databaseChangesTolken)
////        
////        changesOperation.fetchAllChanges = true
////        
//////        changesOperation.fetchDatabaseChangesCompletionBlock = {
//////            (newToken: CKServerChangeToken?, more: Bool, error: Error?) -> Void in
//////            // ...
//////        }
//////
////        //changesOperation.recordZoneWithIDChangedBlock = { self.recordZoneWithIDChanged($0) }
////        //changesOperation.recordZoneWithIDWasDeletedBlock = { self.recordZoneWithIDWasDeleted($0) }
////        changesOperation.changeTokenUpdatedBlock = { self.changeTokenUpdate($0) }
////        changesOperation.fetchDatabaseChangesCompletionBlock = { self.fetchDatabaseChangesCompletion($0, isMoreComing: $1, error: $2) }
////
////       
////        
////    }
//    
//
//}
//
//
//
//
//
//
//
//
//
