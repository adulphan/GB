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
        var oldAccounts: NSOrderedSet
        var oldDate: Date
        
        if let moneyArray = cachedOldValues?.filter({(key,value) -> Bool in
            key == "moneyArray"
        }).first {
            oldMoneyArray = moneyArray.value as! [Double]
        } else {
            oldMoneyArray = self.moneyArray
        }
        
        if let accountArray = cachedOldValues?.filter({(key,value) -> Bool in
            key == "accounts"
        }).first {
            oldAccounts = accountArray.value as! NSOrderedSet
        } else {
            oldAccounts = self.accounts
        }
        
        if let date = cachedOldValues?.filter({(key,value) -> Bool in
            key == "date"
        }).first {
            oldDate = date.value as! Date
        } else {
            oldDate = self.date
        }
        
        handleUpdateFlowsIn(accounts: oldAccounts, moneyArray: oldMoneyArray, date: oldDate, isInsert:false)
        handleUpdateFlowsIn(accounts: self.accounts, moneyArray: self.moneyArray, date: self.date, isInsert:true)
        
        if CoreDataSimulation.main.isSimulating == false {
            CoreData.main.saveData()
        }
        
    }

    func deleteFlows() {

        handleUpdateFlowsIn(accounts: self.accounts, moneyArray: self.moneyArray, date: self.date, isInsert:false)
        if CoreDataSimulation.main.isSimulating == false {
            CoreData.main.saveData()
        }
    }

    func insertFlows() {
        
        handleUpdateFlowsIn(accounts: self.accounts, moneyArray: self.moneyArray, date: self.date, isInsert:true)
        if CoreDataSimulation.main.isSimulating == false {
            CoreData.main.saveData()
        }
    }
    
    private func handleUpdateFlowsIn(accounts: NSOrderedSet, moneyArray: [Double], date: Date, isInsert:Bool) {
        
        let accounts = accounts.array as! [Account]
        let moneyArray = isInsert ? moneyArray : moneyArray.map{$0*(-1)}
        
        for account in accounts {
            
            let index = accounts.index(of: account)!
            let monthEnd = DateFormat.main.standardized(date: date.monthEnd)
            let flowArray = account.flowArray
            
            let withSameMonth = flowArray.filter { (flow) -> Bool in
                flow.monthEnd == monthEnd
            }
            
            if let alreadyCreated = withSameMonth.first {
                alreadyCreated.number += moneyArray[index]
                let flowIndex = flowArray.index(of: alreadyCreated)!
                if flowIndex != 0 {
                    for i in 0...flowIndex-1 {
                        (account.flows?.object(at: i) as! Flow).number += moneyArray[index]
                    }
                }
                
            } else {
                
                let flow = Flow(context: CoreData.main.context)
                flow.monthEnd = monthEnd
                if let flowIndex = flowArray.index(where: {$0.monthEnd < monthEnd}) {
                    flow.number = flowArray[flowIndex].number + moneyArray[index]
                    account.insertIntoFlows(flow, at: flowIndex)
                    if flowIndex != 0 {
                        for i in 0...flowIndex-1 {
                            (account.flows?.object(at: i) as! Flow).number += moneyArray[index]
                        }
                    }
                    
                } else {
                    for object in account.flows! {
                        (object as! Flow).number += moneyArray[index]
                    }
                    flow.number = account.beginBalance + moneyArray[index]
                    account.addToFlows(flow)
                }
                
            }
            
        }

        
    }

}





