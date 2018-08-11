//
//  PushNotifications.swift
//  goldbac
//
//  Created by adulphan youngmod on 6/8/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation
import CloudKit
import AVFoundation

extension Cloudkit {
        
    func handleIncomingNotification() {
        
        print("handleIncomingNotification")
        
        Cloudkit.shared.isActive = false
        Cloudkit.shared.fetchDatabaseChanges(database: database, databaseTokenKey: "private") {
            print("Fetch complete")
            CoreData.shared.saveData()
            Cloudkit.shared.isActive = true
            
            DispatchQueue.main.sync {
                self.tableView?.reloadData()
                let systemSoundID: SystemSoundID = 1057
                AudioServicesPlaySystemSound (systemSoundID)
            }
        }
        
        

    }

    func subscribeToPushNotification() {
        
        let subscriptionID = "cloudkit-personal-account-changes"
        //UserDefaults.standard.removeObject(forKey: subscriptionID)
        
        let subscriptionIsLocallyCached = UserDefaults.standard.bool(forKey: subscriptionID)
        guard !subscriptionIsLocallyCached else {
            return
        }
        
//        let subscription = CKQuerySubscription(recordType: "Account", predicate: NSPredicate(format: "TRUEPREDICATE"), subscriptionID: subscriptionID, options: [.firesOnRecordCreation, .firesOnRecordDeletion, .firesOnRecordUpdate])
//
        let subscription = CKRecordZoneSubscription(zoneID: personalZoneID, subscriptionID: subscriptionID)

        let notificationInfo = CKNotificationInfo()
        notificationInfo.shouldSendContentAvailable = true
        subscription.notificationInfo = notificationInfo
        
        
        database.save(subscription) { (subscription, error) in
            if error == nil {
                print("Subscription: \(subscription?.subscriptionID ?? "xxxxxx"), saved successfully")
                UserDefaults.standard.set(true, forKey: subscriptionID)
            } else {
                print(error!)
            }
        }
        
//        CKContainer.default().publicCloudDatabase.save(subscription, completionHandler: { subscription, error in
//            if error == nil {
//                print("Subscription: \(subscription?.subscriptionID ?? "xxxxxx"), saved successfully")
//                UserDefaults.standard.set(true, forKey: subscriptionID)
//            } else {
//                print(error!)
//            }
//        })
        
    }

}












