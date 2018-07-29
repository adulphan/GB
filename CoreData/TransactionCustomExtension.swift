//
//  TransactionCustomExtension.swift
//  goldbac
//
//  Created by adulphan youngmod on 25/7/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation
import CoreData


extension Transaction {
    
    public override func prepareForDeletion() {       
        if CoreDataSimulation.main.isSimulating == false {
            super.prepareForDeletion()
            deleteFlows()
        }
    }

    public override func didSave() {
        if self.isInserted {
            insertFlows()
            
        } else if !self.isDeleted && !self.isFault && !self.isUpdated {
            editFlows()
        }
        super.didSave()
    }
    
    public override func didChangeValue(forKey key: String) {
        super.didChangeValue(forKey: key)
        cachedOldValues = self.changedValuesForCurrentEvent()
        
    }
    
    var totalAmount: Double {get{ return getTotalAmount()}}
    var fromAccounts: [Account] {get{ return getFromAccounts()}}
    var toAccounts: [Account] {get{return getToAccounts()}}
 
    private func getTotalAmount() -> Double {
        var total:Double = 0
        for amount in self.moneyArray {
            total += abs(amount)
        }
        return total/2
    }
    
    private func getFromAccounts() -> [Account] {
        
        let numberOfToAccounts = self.moneyArray.filter{$0 > 0}.count
        let accountArray = (self.accounts.array as! [Account]).dropLast(numberOfToAccounts)
        
        return Array(accountArray)
    }
    
    private func getToAccounts() -> [Account] {
        
        let numberOfFromAccounts = self.moneyArray.filter{$0 < 0}.count
        let accountArray = (self.accounts.array as! [Account]).dropFirst(numberOfFromAccounts)
        
        return Array(accountArray)
    }

}


extension Date {
    
    var monthEnd: Date {
        get{
            let components = Calendar.current.dateComponents([.year, .month], from: self)
            let startOfMonth = Calendar.current.date(from: components)!
            let firstNextMonth = Calendar.current.date(byAdding: .month, value: 1, to: startOfMonth)!
            let endOfMonth = Calendar.current.date(byAdding: .day, value: -1, to: firstNextMonth)!
            return endOfMonth
        }

    }
}





