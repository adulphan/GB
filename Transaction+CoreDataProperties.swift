//
//  Transaction+CoreDataProperties.swift
//  goldbac
//
//  Created by adulphan youngmod on 24/7/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var date: Date
    @NSManaged public var fullImageRecordID: String?
    @NSManaged public var thumbNailRecordID: String?
    @NSManaged public var modified: Date
    @NSManaged public var moneyArray: [Double]
    @NSManaged public var note: String?
    @NSManaged public var recordID: String
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var accounts: NSOrderedSet

}

// MARK: Generated accessors for accounts
extension Transaction {

    @objc(insertObject:inAccountsAtIndex:)
    @NSManaged public func insertIntoAccounts(_ value: Account, at idx: Int)

    @objc(removeObjectFromAccountsAtIndex:)
    @NSManaged public func removeFromAccounts(at idx: Int)

    @objc(insertAccounts:atIndexes:)
    @NSManaged public func insertIntoAccounts(_ values: [Account], at indexes: NSIndexSet)

    @objc(removeAccountsAtIndexes:)
    @NSManaged public func removeFromAccounts(at indexes: NSIndexSet)

    @objc(replaceObjectInAccountsAtIndex:withObject:)
    @NSManaged public func replaceAccounts(at idx: Int, with value: Account)

    @objc(replaceAccountsAtIndexes:withAccounts:)
    @NSManaged public func replaceAccounts(at indexes: NSIndexSet, with values: [Account])

    @objc(addAccountsObject:)
    @NSManaged public func addToAccounts(_ value: Account)

    @objc(removeAccountsObject:)
    @NSManaged public func removeFromAccounts(_ value: Account)

    @objc(addAccounts:)
    @NSManaged public func addToAccounts(_ values: NSOrderedSet)

    @objc(removeAccounts:)
    @NSManaged public func removeFromAccounts(_ values: NSOrderedSet)

}
