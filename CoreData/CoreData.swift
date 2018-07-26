//
//  CoreData.swift
//  goldbac
//
//  Created by adulphan youngmod on 25/7/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreData {

    static let main = CoreData()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var allAccountsInCoreData:[Account]? {
        get{
            return getAllAccounts()
        }

    }

    private func getAccountsWithType(type: AccountType) -> [Account]? {
        let allAccounts = allAccountsInCoreData
        let accountWithType = allAccounts?.filter({ (account) -> Bool in
            return account.type == Int16(type.rawValue)
        })
        
        print("Account type: \(type)")
        guard let accountArray = accountWithType else {
            print("No account with type: \(type)")
            return nil
        }
        return accountArray
    }

    private func getAllAccounts() -> [Account]? {
        do {
            let fetchRequest = try context.fetch(Account.fetchRequest())
            let accounts = fetchRequest as! [Account]
            if accounts.count == 0 {
                print("No account in CoreData")
            }
            return accounts
        } catch {
            print("Loading Account failed")
            return nil
        }
    }

    enum AccountType : Int {
        
        case cash = 0
        case card = 1
        case bank = 2
        case expense = 3
        case income = 4
        case asset = 5
        case debt = 6
        case equity = 7
    }
}








