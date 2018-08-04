//
//  AccountCoreData+CoreDataProperties.swift
//  goldbac
//
//  Created by adulphan youngmod on 3/8/18.
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
    @NSManaged public var endBalance: Double
    @NSManaged public var monthlyData: NSOrderedSet?
    @NSManaged public var transactions: NSOrderedSet?

}

// MARK: Generated accessors for monthlyData
extension AccountCoreData {

    @objc(insertObject:inMonthlyDataAtIndex:)
    @NSManaged public func insertIntoMonthlyData(_ value: MonthCoreData, at idx: Int)

    @objc(removeObjectFromMonthlyDataAtIndex:)
    @NSManaged public func removeFromMonthlyData(at idx: Int)

    @objc(insertMonthlyData:atIndexes:)
    @NSManaged public func insertIntoMonthlyData(_ values: [MonthCoreData], at indexes: NSIndexSet)

    @objc(removeMonthlyDataAtIndexes:)
    @NSManaged public func removeFromMonthlyData(at indexes: NSIndexSet)

    @objc(replaceObjectInMonthlyDataAtIndex:withObject:)
    @NSManaged public func replaceMonthlyData(at idx: Int, with value: MonthCoreData)

    @objc(replaceMonthlyDataAtIndexes:withMonthlyData:)
    @NSManaged public func replaceMonthlyData(at indexes: NSIndexSet, with values: [MonthCoreData])

    @objc(addMonthlyDataObject:)
    @NSManaged public func addToMonthlyData(_ value: MonthCoreData)

    @objc(removeMonthlyDataObject:)
    @NSManaged public func removeFromMonthlyData(_ value: MonthCoreData)

    @objc(addMonthlyData:)
    @NSManaged public func addToMonthlyData(_ values: NSOrderedSet)

    @objc(removeMonthlyData:)
    @NSManaged public func removeFromMonthlyData(_ values: NSOrderedSet)

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
