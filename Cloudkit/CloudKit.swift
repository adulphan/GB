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
    
    let isActive:Bool = false
    let lastFetchUserDefaultKey = "lastFetchUserDefaultKey"
    
}







