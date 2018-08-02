//
//  TransactionCoreData+CoreDataProperties.swift
//  goldbac
//
//  Created by adulphan youngmod on 2/8/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//
//

import Foundation
import CoreData


extension TransactionCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionCoreData> {
        return NSFetchRequest<TransactionCoreData>(entityName: "TransactionCoreData")
    }

    @NSManaged public var date: Date?
    @NSManaged public var fullImageRecordID: String?
    @NSManaged public var modified: Date?
    @NSManaged public var moneyArray: [Double]?
    @NSManaged public var note: String?
    @NSManaged public var recordID: String?
    @NSManaged public var thumbnailRecordID: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var accounts: NSOrderedSet?

}

// MARK: Generated accessors for accounts
extension TransactionCoreData {

    @objc(insertObject:inAccountsAtIndex:)
    @NSManaged public func insertIntoAccounts(_ value: AccountCoreData, at idx: Int)

    @objc(removeObjectFromAccountsAtIndex:)
    @NSManaged public func removeFromAccounts(at idx: Int)

    @objc(insertAccounts:atIndexes:)
    @NSManaged public func insertIntoAccounts(_ values: [AccountCoreData], at indexes: NSIndexSet)

    @objc(removeAccountsAtIndexes:)
    @NSManaged public func removeFromAccounts(at indexes: NSIndexSet)

    @objc(replaceObjectInAccountsAtIndex:withObject:)
    @NSManaged public func replaceAccounts(at idx: Int, with value: AccountCoreData)

    @objc(replaceAccountsAtIndexes:withAccounts:)
    @NSManaged public func replaceAccounts(at indexes: NSIndexSet, with values: [AccountCoreData])

    @objc(addAccountsObject:)
    @NSManaged public func addToAccounts(_ value: AccountCoreData)

    @objc(removeAccountsObject:)
    @NSManaged public func removeFromAccounts(_ value: AccountCoreData)

    @objc(addAccounts:)
    @NSManaged public func addToAccounts(_ values: NSOrderedSet)

    @objc(removeAccounts:)
    @NSManaged public func removeFromAccounts(_ values: NSOrderedSet)

}
