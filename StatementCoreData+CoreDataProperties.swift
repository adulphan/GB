//
//  StatementCoreData+CoreDataProperties.swift
//  goldbac
//
//  Created by adulphan youngmod on 2/8/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//
//

import Foundation
import CoreData


extension StatementCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StatementCoreData> {
        return NSFetchRequest<StatementCoreData>(entityName: "StatementCoreData")
    }

    @NSManaged public var balance: Double
    @NSManaged public var endDate: Date?
    @NSManaged public var flow: Double
    @NSManaged public var account: AccountCoreData?

}
