//
//  ManageCoreData.swift
//  goldbac
//
//  Created by adulphan youngmod on 25/7/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension CoreData {
    
    func saveData() {
        do { try context.save() }
        catch { print("Saving CoreData failed") }
    }
    
    func printData() {
        
        do {
            
            let fetchRequest = try context.fetch(Account.fetchRequest())
            let accounts = fetchRequest as! [Account]
            print("Number of accounts: \(fetchRequest.count)")
            for account in accounts {
                print("\(account.name): \(account.recordID)")
            }
            
        } catch {print("Fetching Account failed")}
        
        do {
            
            let fetchRequest = try context.fetch(Transaction.fetchRequest())
            let transactions = fetchRequest as! [Transaction]
            print("Number of transactions: \(fetchRequest.count)")
            for transaction in transactions {                
                print("\(transaction.title ?? "No title"): \(transaction.recordID)")
            }
            
        } catch {print("Fetching Account failed")}
    }
    
    func clearAllCoreData(){

        do {
            let result = try context.fetch(Account.fetchRequest())
            for object in result {
                context.delete(object as! NSManagedObject)
            }
            
        } catch {
            print("Deleting Account failed")
        }

        do {

            let result = try context.fetch(Transaction.fetchRequest())
            for object in result {
                context.delete(object as! NSManagedObject)
            }
            
        } catch {
            print("Deleting Transaction failed")
        }

    }

}















