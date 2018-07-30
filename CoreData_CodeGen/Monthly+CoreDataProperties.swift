//
//  Monthly+CoreDataProperties.swift
//  goldbac
//
//  Created by adulphan youngmod on 30/7/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//
//

import Foundation
import CoreData


extension Monthly {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Monthly> {
        return NSFetchRequest<Monthly>(entityName: "Monthly")
    }

    @NSManaged public var endDate: Date
    @NSManaged public var flow: Double
    @NSManaged public var balance: Double
    @NSManaged public var account: Account

}
