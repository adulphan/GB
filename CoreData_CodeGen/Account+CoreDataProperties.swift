//
//  Account+CoreDataProperties.swift
//  goldbac
//
//  Created by adulphan youngmod on 30/7/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//
//

import Foundation
import CoreData


extension Account {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Account> {
        return NSFetchRequest<Account>(entityName: "Account")
    }

    @NSManaged public var beginBalance: Double
    @NSManaged public var imageRecordID: String?
    @NSManaged public var name: String
    @NSManaged public var recordID: String
    @NSManaged public var type: Int16
    @NSManaged public var monthly: NSOrderedSet?
    @NSManaged public var transactions: NSOrderedSet?

}

// MARK: Generated accessors for monthly
extension Account {

    @objc(insertObject:inMonthlyAtIndex:)
    @NSManaged public func insertIntoMonthly(_ value: Monthly, at idx: Int)

    @objc(removeObjectFromMonthlyAtIndex:)
    @NSManaged public func removeFromMonthly(at idx: Int)

    @objc(insertMonthly:atIndexes:)
    @NSManaged public func insertIntoMonthly(_ values: [Monthly], at indexes: NSIndexSet)

    @objc(removeMonthlyAtIndexes:)
    @NSManaged public func removeFromMonthly(at indexes: NSIndexSet)

    @objc(replaceObjectInMonthlyAtIndex:withObject:)
    @NSManaged public func replaceMonthly(at idx: Int, with value: Monthly)

    @objc(replaceMonthlyAtIndexes:withMonthly:)
    @NSManaged public func replaceMonthly(at indexes: NSIndexSet, with values: [Monthly])

    @objc(addMonthlyObject:)
    @NSManaged public func addToMonthly(_ value: Monthly)

    @objc(removeMonthlyObject:)
    @NSManaged public func removeFromMonthly(_ value: Monthly)

    @objc(addMonthly:)
    @NSManaged public func addToMonthly(_ values: NSOrderedSet)

    @objc(removeMonthly:)
    @NSManaged public func removeFromMonthly(_ values: NSOrderedSet)

}

// MARK: Generated accessors for transactions
extension Account {

    @objc(insertObject:inTransactionsAtIndex:)
    @NSManaged public func insertIntoTransactions(_ value: Transaction, at idx: Int)

    @objc(removeObjectFromTransactionsAtIndex:)
    @NSManaged public func removeFromTransactions(at idx: Int)

    @objc(insertTransactions:atIndexes:)
    @NSManaged public func insertIntoTransactions(_ values: [Transaction], at indexes: NSIndexSet)

    @objc(removeTransactionsAtIndexes:)
    @NSManaged public func removeFromTransactions(at indexes: NSIndexSet)

    @objc(replaceObjectInTransactionsAtIndex:withObject:)
    @NSManaged public func replaceTransactions(at idx: Int, with value: Transaction)

    @objc(replaceTransactionsAtIndexes:withTransactions:)
    @NSManaged public func replaceTransactions(at indexes: NSIndexSet, with values: [Transaction])

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: Transaction)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: Transaction)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSOrderedSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSOrderedSet)

}
