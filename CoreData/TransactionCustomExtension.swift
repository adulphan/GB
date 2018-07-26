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
    
    var totalAmount: Double {
        get{
            return getTotalAmount()
        }
    }
    
    var fromAccounts: [Account] {
        get{
            return getFromAccounts()
        }
    }
    
    var toAccounts: [Account] {
        get{
            return getToAccounts()
        }
    }
    
    //var fromAccountsString: String
    
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








