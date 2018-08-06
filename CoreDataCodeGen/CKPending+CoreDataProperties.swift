//
//  CKPending+CoreDataProperties.swift
//  goldbac
//
//  Created by adulphan youngmod on 6/8/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//
//

import Foundation
import CoreData
import CloudKit


extension CKPending {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CKPending> {
        return NSFetchRequest<CKPending>(entityName: "CKPending")
    }

    @NSManaged public var record: CKRecord?
    @NSManaged public var toDelete: Bool
    @NSManaged public var date: Date?

}
