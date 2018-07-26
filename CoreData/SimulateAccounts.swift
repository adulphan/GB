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

extension CoreData {
    
//    func simulateTransaction() {
        
//        let accounts = allAccountsInCoreData
//        
//        let groceryTitle = ["Big C","Tesco Online"]
//        let cashTitle = ["Withdraw Cash"]
//        let utilityTitle = ["Monthly electricity", "Water utility"]
//        let eatOutTitle = ["MK Suki","McDonald"]
//        let carTitle = ["Clean Vigo","Clean Yaris"]
//        let transferTitle = ["Invest in Land","Buy stocks"]
//        let catTitle = ["Buy cat food", "Cat vaccine"]
//        let medicalTitle = ["Mom medical", "Vitamin B12"]
//        let titles = groceryTitle + cashTitle + utilityTitle + eatOutTitle + carTitle + transferTitle + catTitle + medicalTitle
//        let randomTitle = titles[randomInt(min: 0, max: titles.count-1)]
//        
//        switch <#value#> {
//        case <#pattern#>:
//            <#code#>
//        default:
//            <#code#>
//        }
//        
//        
//        
//        let accountsCounterpart = []
//        
//        let newTransaction = Transaction(context: context)
//        newTransaction.title
        
//    }
    
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
                let recordID = UUID().uuidString
                newAcount.recordID = recordID
            }
        }
        
        CoreData.main.saveData()
        
    }
    

    
}







