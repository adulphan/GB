//
//  ClearData.swift
//  goldbac
//
//  Created by adulphan youngmod on 4/8/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation
import UIKit
import CoreData


extension SimulateData {

    func clearAllCoreData(){
        
        isClearingData = true
        Cloudkit.shared.isActive = false
        let context = CoreData.shared.context
        
        do {
            let result = try context.fetch(AccountCoreData.fetchRequest())
            for object in result {
                context.delete(object as! NSManagedObject)
            }
            
        } catch {
            print("Deleting Account failed: \(error)")
        }
        
        
        do {
            let result = try context.fetch(TransactionCoreData.fetchRequest())
            for object in result {
                context.delete(object as! NSManagedObject)
            }
            
        } catch {
            print("Deleting Transaction failed: \(error)")
        }
        
        do {
            let result = try context.fetch(CKPending.fetchRequest())
            for object in result {
                context.delete(object as! NSManagedObject)
            }
            
        } catch {
            print("Deleting CKPending failed: \(error)")
        }
        
        CoreData.shared.saveData()
        isClearingData = false
        Cloudkit.shared.isActive = true
    }
}




