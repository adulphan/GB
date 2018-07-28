//
//  Account+CoreDataProperties.swift
//  goldbac
//
//  Created by adulphan youngmod on 27/7/18.
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
    @NSManaged public var transactions: NSOrderedSet?
    @NSManaged public var flows: NSOrderedSet?

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

// MARK: Generated accessors for flows
extension Account {

    @objc(insertObject:inFlowsAtIndex:)
    @NSManaged public func insertIntoFlows(_ value: Flow, at idx: Int)

    @objc(removeObjectFromFlowsAtIndex:)
    @NSManaged public func removeFromFlows(at idx: Int)

    @objc(insertFlows:atIndexes:)
    @NSManaged public func insertIntoFlows(_ values: [Flow], at indexes: NSIndexSet)

    @objc(removeFlowsAtIndexes:)
    @NSManaged public func removeFromFlows(at indexes: NSIndexSet)

    @objc(replaceObjectInFlowsAtIndex:withObject:)
    @NSManaged public func replaceFlows(at idx: Int, with value: Flow)

    @objc(replaceFlowsAtIndexes:withFlows:)
    @NSManaged public func replaceFlows(at indexes: NSIndexSet, with values: [Flow])

    @objc(addFlowsObject:)
    @NSManaged public func addToFlows(_ value: Flow)

    @objc(removeFlowsObject:)
    @NSManaged public func removeFromFlows(_ value: Flow)

    @objc(addFlows:)
    @NSManaged public func addToFlows(_ values: NSOrderedSet)

    @objc(removeFlows:)
    @NSManaged public func removeFromFlows(_ values: NSOrderedSet)

}
