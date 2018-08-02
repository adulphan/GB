////
////  TransactionCustomExtension.swift
////  goldbac
////
////  Created by adulphan youngmod on 25/7/18.
////  Copyright © 2018 goldbac Inc. All rights reserved.
////
//
//import Foundation
//import CoreData
//
//
//extension Transaction {
//    
//    public override func prepareForDeletion() {       
//        if CoreDataSimulation.main.isSimulating == false {
//            super.prepareForDeletion()
//            deleteFlows()
//        }
//    }
//
//    public override func didSave() {
//        if self.isInserted {
//            insertFlows()
//            
//        } else if !self.isDeleted && !self.isFault && !self.isUpdated {
//            editFlows()
//        }
//        super.didSave()
//    }
//    
//    public override func didChangeValue(forKey key: String) {
//        super.didChangeValue(forKey: key)
//        cachedOldValues = self.changedValuesForCurrentEvent()
//        
//    }
//    
//    var totalAmount: Double {get{ return getTotalAmount()}}
//    var fromAccounts: [Account] {get{ return getFromAccounts()}}
//    var toAccounts: [Account] {get{return getToAccounts()}}
//    
//    func getMoneyFor(account: Account) -> Double {
//        if let index = (self.accounts.array as! [Account]).index(of: account) {
//            let money = self.moneyArray[index]
//            return money
//        } else {
//            
//            return 0
//        }
//    }
// 
//    private func getTotalAmount() -> Double {
//        var total:Double = 0
//        for amount in self.moneyArray {
//            total += abs(amount)
//        }
//        return total/2
//    }
//    
//    private func getFromAccounts() -> [Account] {
//        
//        let numberOfToAccounts = self.moneyArray.filter{$0 > 0}.count
//        let accountArray = (self.accounts.array as! [Account]).dropLast(numberOfToAccounts)
//        
//        return Array(accountArray)
//    }
//    
//    private func getToAccounts() -> [Account] {
//        
//        let numberOfFromAccounts = self.moneyArray.filter{$0 < 0}.count
//        let accountArray = (self.accounts.array as! [Account]).dropFirst(numberOfFromAccounts)
//        
//        return Array(accountArray)
//    }
//
//}
//
//
//
//
//
//
