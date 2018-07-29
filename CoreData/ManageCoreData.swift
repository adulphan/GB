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
        catch { print("Saving CoreData failed: \(error)") }
    }
    
    func clearAllCoreData(){

        CoreDataSimulation.main.isSimulating = true
        do {
            
            let result = try context.fetch(Flow.fetchRequest())
            for object in result {
                context.delete(object as! NSManagedObject)
            }
            
        } catch {
            print("Deleting Flows failed: \(error)")
        }
        
        do {
            
            let result = try context.fetch(Transaction.fetchRequest())
            for object in result {
                context.delete(object as! NSManagedObject)
            }
            
        } catch {
            print("Deleting Transaction failed: \(error)")
        }
        
        do {
            let result = try context.fetch(Account.fetchRequest())
            for object in result {
                context.delete(object as! NSManagedObject)
            }
            
        } catch {
            print("Deleting Account failed: \(error)")
        }
        
        CoreData.main.saveData()
        CoreDataSimulation.main.isSimulating = false
    }

}















