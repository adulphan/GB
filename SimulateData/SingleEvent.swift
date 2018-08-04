//
//  SimulateSingleTransaction.swift
//  goldbac
//
//  Created by adulphan youngmod on 4/8/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation
import UIKit
import CoreData


extension SimulateData {
    
    func simulateDeleteTransaciton() {
        print("Simulate delete")
        let transactions = CoreData.app.allTransactionsInCoreData!
        let victim = transactions[0]
        CoreData.app.context.delete(victim)
        CoreData.app.saveData()
        
    }
    
    func simulateInsertTransaction() {
        print("Simulate insert")
        let transactions = CoreData.app.allTransactionsInCoreData!
        let sample = transactions[0]
        
        let newBorn = Transaction()
        newBorn.referenceTo(coreData: sample)
        newBorn.addToCoreData()
        CoreData.app.saveData()
        
    }
    
    func simulateEditTransaction() {
        print("Simulate edit")
        let transactions = CoreData.app.allTransactionsInCoreData!
        let victim = transactions[3]
        
        victim.note = "New note"
        
        let newAccount = SimulateData.app.accountsDictionary["chase"]!
        victim.replaceAccounts(at: 0, with: newAccount)
        CoreData.app.saveData()
        
    }
    
    
    
    
    
}
