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

    @NSManaged public var date: NSDate?
    @NSManaged public var imageRecoredID: NSObject?
    @NSManaged public var modified: NSDate?
    @NSManaged public var moneyArray: NSObject?
    @NSManaged public var note: String?
    @NSManaged public var recordID: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var accounts: NSSet?

}

// MARK: Generated accessors for accounts
extension Transaction {

    @objc(addAccountsObject:)
    @NSManaged public func addToAccounts(_ value: Account)

    @objc(removeAccountsObject:)
    @NSManaged public func removeFromAccounts(_ value: Account)

    @objc(addAccounts:)
    @NSManaged public func addToAccounts(_ values: NSSet)

    @objc(removeAccounts:)
    @NSManaged public func removeFromAccounts(_ values: NSSet)

}
