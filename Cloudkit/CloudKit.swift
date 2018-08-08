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
        case deleted = "DeletedRecord"
    }
    
    var isActive:Bool = true
    let lastFetchUserDefaultKey = "lastFetchUserDefaultKey"
    
    var tableView:UITableView?
    
}







