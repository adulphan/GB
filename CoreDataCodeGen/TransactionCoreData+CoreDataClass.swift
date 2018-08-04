//
//  TransactionCoreData+CoreDataClass.swift
//  goldbac
//
//  Created by adulphan youngmod on 3/8/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//
//

import Foundation
import CoreData


public class TransactionCoreData: NSManagedObject {

    var cachedLastCommitted:Transaction?
    var wasUpdated:Bool = false
    
}
