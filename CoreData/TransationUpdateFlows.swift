//
//  TransationUpdateFlows.swift
//  goldbac
//
//  Created by adulphan youngmod on 28/7/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension Transaction {
    
    func editFlows() {
        
        if cachedOldValues?.filter({(key,value) -> Bool in
            key == "moneyArray" || key == "accounts" || key == "date"
        }).count == 0 { return }
        
        var oldMoneyArray: [Double]
        var oldAccounts: [Account]
        var oldDate: Date
        
        if let moneyArray = cachedOldValues?.filter({(key,value) -> Bool in
            key == "moneyArray"
        }).first {
            
            print(moneyArray.value)
            
            oldMoneyArray = moneyArray.value as! [Double]
        } else {
            oldMoneyArray = self.moneyArray
        }
        
        if let accountArray = cachedOldValues?.filter({(key,value) -> Bool in
            key == "accounts"
        }).first {
            oldAccounts = (accountArray.value as! NSOrderedSet).array as! [Account]
        } else {
            oldAccounts = self.accounts.array as! [Account]
        }
        
        if let date = cachedOldValues?.filter({(key,value) -> Bool in
            key == "date"
        }).first {
            oldDate = date.value as! Date
        } else {
            oldDate = self.date
        }
        
        print(oldMoneyArray)
        print(oldAccounts.map{$0.name})
        print(oldDate)
        
        
        for account in oldAccounts {
            let index = oldAccounts.index(of: account)!
            let monthEnd = DateFormat.main.standardized(date: oldDate.monthEnd)
            
            let monthFlow = account.flowArray.filter { (flow) -> Bool in
                flow.monthEnd == monthEnd
                }.first!
            
            monthFlow.number -= oldMoneyArray[index]
            
        }
        
        print(self.moneyArray)
        print((self.accounts.array as! [Account]).map{$0.name})
        print(self.date)
        
        insertFlows()
        
    }

    func deleteFlows() {
        let accounts = self.accounts.array as! [Account]
        let moneyArray = self.moneyArray
        
        for account in accounts {
            let index = accounts.index(of: account)!
            
            let monthEnd = DateFormat.main.standardized(date: self.date.monthEnd)
            let flowArray = account.flowArray
            
            let withSameMonth = flowArray.filter { (flow) -> Bool in
                flow.monthEnd == monthEnd
            }
            
            if let alreadyCreated = withSameMonth.first {
                alreadyCreated.number += -moneyArray[index]
                if alreadyCreated.number == Double(0) {
                    CoreData.main.context.delete(alreadyCreated)
                }
            }
            
        }
        CoreData.main.saveData()
    }

    func insertFlows() {
        let accounts = self.accounts.array as! [Account]
        let moneyArray = self.moneyArray
        
        for account in accounts {
            
            let index = accounts.index(of: account)!
            let monthEnd = DateFormat.main.standardized(date: self.date.monthEnd)
            let flowArray = account.flowArray
            
            let withSameMonth = flowArray.filter { (flow) -> Bool in
                flow.monthEnd == monthEnd
            }
            
            if let alreadyCreated = withSameMonth.first {
                alreadyCreated.number += moneyArray[index]
                
            } else {
                
                let flow = Flow(context: CoreData.main.context)
                flow.account = account
                flow.number = moneyArray[index]
                flow.monthEnd = monthEnd
                
            }
        }
        
        CoreData.main.saveData()
        
    }

}





