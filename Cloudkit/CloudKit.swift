//
//  CloudKit.swift
//  goldbac
//
//  Created by adulphan youngmod on 5/8/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import CloudKit
import UIKit


class Cloudkit {
    
    static let shared = Cloudkit()
    
    enum recordType : String {
        case account = "Account"
        case transaction = "Transaction"
    }
    
    var isActive:Bool = true
    let lastFetchUserDefaultKey = "lastFetchUserDefaultKey"
    
    var tableView:UITableView?
    let database = CKContainer.default().privateCloudDatabase
    let personalZoneID = CKRecordZone(zoneName: "Personal").zoneID

    let databaseChangeToken = "databaseChangeToken"
    let zoneChangeToken = "zoneChangeToken"
    
}

public extension UserDefaults {
    
    public var databaseChangeToken: CKServerChangeToken? {
        get {
            guard let data = self.value(forKey: "databaseChangeToken") as? Data else {
                return nil
            }
            
            guard let token = NSKeyedUnarchiver.unarchiveObject(with: data) as? CKServerChangeToken else {
                return nil
            }
            
            return token
        }
        set {
            if let token = newValue {
                let data = NSKeyedArchiver.archivedData(withRootObject: token)
                self.set(data, forKey: "databaseChangeToken")
            } else {
                self.removeObject(forKey: "databaseChangeToken")
            }
        }
    }
    
    public var zoneChangeToken: CKServerChangeToken? {
        get {
            guard let data = self.value(forKey: "zoneChangeToken") as? Data else {
                return nil
            }
            
            guard let token = NSKeyedUnarchiver.unarchiveObject(with: data) as? CKServerChangeToken else {
                return nil
            }
            
            return token
        }
        set {
            if let token = newValue {
                let data = NSKeyedArchiver.archivedData(withRootObject: token)
                self.set(data, forKey: "zoneChangeToken")
            } else {
                self.removeObject(forKey: "zoneChangeToken")
            }
        }
    }
}





