//
//  MonthCoreData+CoreDataProperties.swift
//  goldbac
//
//  Created by adulphan youngmod on 3/8/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//
//

import Foundation
import CoreData


extension MonthCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MonthCoreData> {
        return NSFetchRequest<MonthCoreData>(entityName: "MonthCoreData")
    }

    @NSManaged public var balance: Double
    @NSManaged public var endDate: Date?
    @NSManaged public var flow: Double
    @NSManaged public var account: AccountCoreData?

}
