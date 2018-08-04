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
        let context = CoreData.app.context
        
        do {
            let result = try context.fetch(AccountCoreData.fetchRequest())
            for object in result {
                context.delete(object as! NSManagedObject)
            }
            
        } catch {
            print("Deleting Account failed: \(error)")
        }
        
        CoreData.app.saveData()
        isClearingData = false
    }
}




