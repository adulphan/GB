//
//  Flow+CoreDataProperties.swift
//  goldbac
//
//  Created by adulphan youngmod on 27/7/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//
//

import Foundation
import CoreData


extension Flow {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Flow> {
        return NSFetchRequest<Flow>(entityName: "Flow")
    }

    @NSManaged public var number: Double
    @NSManaged public var monthEnd: Date
    @NSManaged public var account: Account

}
