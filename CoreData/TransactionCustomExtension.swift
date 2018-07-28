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
    
    public override func didSave() {
        super.didSave()
        
        if self.isDeleted {
            
            print("\(self.recordID) is deleted")
            self.deleteFlows()
            
        } else if self.isUpdated {
            
            print("\(self.recordID) is updated")
            
        } else if self.isInserted {
            
            print("\(self.recordID) is inserted")
            
            self.insertFlows()
            
        } else if self.isFault {
            
            print("\(self.recordID) is fault")
        } else {
            
            print("\(self.recordID) is doing sth else")
        }
        
        
    }
    
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
    
    
    private func deleteFlows() {
//        let accounts = self.accounts
//        let moneyArray = self.moneyArray
//        
//        for i in 0...accounts.count-1 {
//            let account = accounts.array[i] as! Account
//            
//            let monthEnd = DateFormat.main.standardized(date: self.date.monthEnd)
//            let flowArray = account.flowArray
//            
//            let withSameMonth = flowArray.filter { (flow) -> Bool in
//                flow.monthEnd == monthEnd
//            }
//            
//            if let alreadyCreated = withSameMonth.first {
//                alreadyCreated.number += -moneyArray[i]
//                
//            }
//
//        }
//        
//        CoreData.main.saveData()
    }
    
    private func insertFlows() {
        let accounts = self.accounts
        let moneyArray = self.moneyArray
        
        for i in 0...accounts.count-1 {
            let account = accounts.array[i] as! Account
            
            let monthEnd = DateFormat.main.standardized(date: self.date.monthEnd)
            let flowArray = account.flowArray
            
            let withSameMonth = flowArray.filter { (flow) -> Bool in
                flow.monthEnd == monthEnd
            }
                
            if let alreadyCreated = withSameMonth.first {
                
                alreadyCreated.number += moneyArray[i]
                
            } else {
            
                let flow = Flow(context: CoreData.main.context)
                flow.account = account
                flow.number = moneyArray[i]
                flow.monthEnd = monthEnd
                
            }
        }
        
        CoreData.main.saveData()
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





