//
//  Account+CoreDataProperties.swift
//  goldbac
//
//  Created by adulphan youngmod on 24/7/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//
//

import Foundation
import CoreData


extension Account {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Account> {
        return NSFetchRequest<Account>(entityName: "Account")
    }

    @NSManaged public var imageRecordID: String?
    @NSManaged public var name: String?
    @NSManaged public var recordID: String?
    @NSManaged public var transactions: NSSet?

}

// MARK: Generated accessors for transactions
extension Account {

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: Transaction)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: Transaction)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSSet)

}
