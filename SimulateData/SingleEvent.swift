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
        let transactions = CoreData.shared.allTransactionsInCoreData!
        let victim = transactions[0]
        CoreData.shared.context.delete(victim)
        CoreData.shared.saveData()
        
    }
    
    func simulateInsertTransaction() {
        print("Simulate insert")
        let transactions = CoreData.shared.allTransactionsInCoreData!
        let sample = transactions[0]
        
        let newBorn = Transaction()
        newBorn.referenceTo(coreData: sample)
        newBorn.addToCoreData()
        CoreData.shared.saveData()
        
    }
    
    func simulateEditTransaction() {
        print("Simulate edit")
        let transactions = CoreData.shared.allTransactionsInCoreData!
        let victim = transactions[3]
        
        victim.note = "New note"
        
        let newAccount = SimulateData.shared.accountsDictionary["chase"]!
        victim.replaceAccounts(at: 0, with: newAccount)
        CoreData.shared.saveData()
        
    }
    
    
    
    
    
}
