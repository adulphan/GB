//
//  AccountCoreData+CoreDataProperties.swift
//  goldbac
//
//  Created by adulphan youngmod on 2/8/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//
//

import Foundation
import CoreData


extension AccountCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AccountCoreData> {
        return NSFetchRequest<AccountCoreData>(entityName: "AccountCoreData")
    }

    @NSManaged public var beginBalance: Double
    @NSManaged public var imageRecordID: String?
    @NSManaged public var name: String?
    @NSManaged public var recordID: String?
    @NSManaged public var type: Int16
    @NSManaged public var statement: NSOrderedSet?
    @NSManaged public var transactions: NSOrderedSet?

}

// MARK: Generated accessors for statement
extension AccountCoreData {

    @objc(insertObject:inStatementAtIndex:)
    @NSManaged public func insertIntoStatement(_ value: StatementCoreData, at idx: Int)

    @objc(removeObjectFromStatementAtIndex:)
    @NSManaged public func removeFromStatement(at idx: Int)

    @objc(insertStatement:atIndexes:)
    @NSManaged public func insertIntoStatement(_ values: [StatementCoreData], at indexes: NSIndexSet)

    @objc(removeStatementAtIndexes:)
    @NSManaged public func removeFromStatement(at indexes: NSIndexSet)

    @objc(replaceObjectInStatementAtIndex:withObject:)
    @NSManaged public func replaceStatement(at idx: Int, with value: StatementCoreData)

    @objc(replaceStatementAtIndexes:withStatement:)
    @NSManaged public func replaceStatement(at indexes: NSIndexSet, with values: [StatementCoreData])

    @objc(addStatementObject:)
    @NSManaged public func addToStatement(_ value: StatementCoreData)

    @objc(removeStatementObject:)
    @NSManaged public func removeFromStatement(_ value: StatementCoreData)

    @objc(addStatement:)
    @NSManaged public func addToStatement(_ values: NSOrderedSet)

    @objc(removeStatement:)
    @NSManaged public func removeFromStatement(_ values: NSOrderedSet)

}

// MARK: Generated accessors for transactions
extension AccountCoreData {

    @objc(insertObject:inTransactionsAtIndex:)
    @NSManaged public func insertIntoTransactions(_ value: TransactionCoreData, at idx: Int)

    @objc(removeObjectFromTransactionsAtIndex:)
    @NSManaged public func removeFromTransactions(at idx: Int)

    @objc(insertTransactions:atIndexes:)
    @NSManaged public func insertIntoTransactions(_ values: [TransactionCoreData], at indexes: NSIndexSet)

    @objc(removeTransactionsAtIndexes:)
    @NSManaged public func removeFromTransactions(at indexes: NSIndexSet)

    @objc(replaceObjectInTransactionsAtIndex:withObject:)
    @NSManaged public func replaceTransactions(at idx: Int, with value: TransactionCoreData)

    @objc(replaceTransactionsAtIndexes:withTransactions:)
    @NSManaged public func replaceTransactions(at indexes: NSIndexSet, with values: [TransactionCoreData])

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: TransactionCoreData)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: TransactionCoreData)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSOrderedSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSOrderedSet)

}
