//
//  FilePaper.swift
//  goldbac
//
//  Created by adulphan youngmod on 31/7/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation


func testExample() {
    
    let allAccounts = CoreData.main.allAccountsInCoreData!
    
    for i in 0...allAccounts.count-1 {
        
        let account = allAccounts[i]
        let transactions = account.transactionArray
        let earliestDate = transactions.first?.date
        let oldestDate = transactions.last?.date
        let numberOfMonths = DateFormat.main.calendar.dateComponents([.month], from: oldestDate!, to: earliestDate!).month!
        
        for i in 0...numberOfMonths-1 {
            
            let date = DateFormat.main.calendar.date(byAdding: .month, value: -i, to: earliestDate!)
            let month = DateFormat.main.calendar.dateComponents([.month], from: date!)
            
            let transactionInSameMonth = transactions.filter { (transaction) -> Bool in
                DateFormat.main.calendar.dateComponents([.month], from: transaction.date) == month
            }
            
            var totalMonthFlow:Double = 0
            for transaction in transactionInSameMonth{
                totalMonthFlow += transaction.getMoneyFor(account: account)
            }
            
            let appGeneratedFlow = account.monthlyArray[i].flow
            
            XCTAssertEqual(totalMonthFlow, appGeneratedFlow)
            
        }
        
    }
    
    
}
