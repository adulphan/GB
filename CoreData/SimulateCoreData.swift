//
//  SimulateCoreData.swift
//  goldbac
//
//  Created by adulphan youngmod on 25/7/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation

extension CoreData {
    
    enum AccountType : Int {
        
        case cash = 0
        case card = 1
        case bank = 2
        case expense = 3
        case income = 4
        case asset = 5
        case debt = 6
        case equity = 7
    }
    
    func simulateTransaction() {
        
        
        
    }
    
    func simulateAccounts() {
        
        let cashName = ["wallet"]
        let cardName = ["ktc","amex","citi"]
        let bankName = ["bofa","kbank","barclays","scb","ing","bbl","chase","suntrust"]
        let expenseName = ["grocery","eatout","fuel","internet","electricity","water","medical","repair","home","car","cat","appliance","duvet","sneaker","netflix","charity","furniture"]
        let incomeName = ["salary, interests"]
        let assetName = ["savings","condo","factory","land","stock","bitcoins","bond","inventory"]
        let debtName = ["loan","autoLease","homeLoan","personalLoan"]
        let equityName = ["adjustmant","paidup"]
        let accountName = [cashName,cardName,bankName,expenseName,incomeName,assetName,debtName,equityName]
        
        for array in accountName {
            let type = accountName.index(of: array)!
            for name in array {
                let newAcount = Account(context: context)
                newAcount.name = String(name.uppercased().first!) + String(name.dropFirst())
                newAcount.type = Int16(type)
                let recordID = UUID().uuidString + ".account"
                newAcount.recordID = recordID
            }
        }
        
        CoreData.main.saveData()
        
    }
    
    
    
}







