//
//  SimulateAccounts.swift
//  goldbac
//
//  Created by adulphan youngmod on 25/7/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension CoreDataSimulation {

    func simulateAccounts() {
        
        let cashName = ["wallet"]
        let cardName = ["amex","citi"]
        let bankName = ["bofa","barclays","chase","suntrust"]
        let expenseName = ["grocery","eatout","fuel","utility","medical","home","car","appliance","subscription","family","interest expense"]
        let incomeName = ["salary", "interest income"]
        let assetName = ["savings","land","stock"]
        let debtName = ["auto leasing","homeLoan","personalLoan"]
        let equityName = ["adjustmant","paidup"]
        let accountName = [cashName,cardName,bankName,expenseName,incomeName,assetName,debtName,equityName]

        for array in accountName {
            let type = accountName.index(of: array)!
            for name in array {
                let newAcount = Account(context: context)
                newAcount.name = String(name.uppercased().first!) + String(name.dropFirst())
                newAcount.type = Int16(type)
                let recordID = UUID().uuidString
                newAcount.recordID = recordID
                newAcount.beginBalance = 0                
                accountsDictionary[name] = newAcount
            }
        }
        
        CoreData.main.saveData()
        
    }
    
    func printNumberOftransactionIn(accounts:[Account]) {
        
        var total:Int = 0
        for account in accounts {
            let count = account.transactions?.count
            printSequenceOf(contents: [account.name,"\(count ?? 0)"])
            total += count!
        }

        print("Total splitBits: \(total)")
    }
    
    
}







