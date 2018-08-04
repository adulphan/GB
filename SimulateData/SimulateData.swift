//
//  SimulateData.swift
//  goldbac
//
//  Created by adulphan youngmod on 3/8/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class SimulateData {
    static let app = SimulateData()
    var accountsDictionary:[String:AccountCoreData] = [:]
    var isClearingData:Bool = true
    
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
                let newAcount = AccountCoreData(context: CoreData.app.context)
                newAcount.name = String(name.uppercased().first!) + String(name.dropFirst())
                newAcount.type = Int16(type)
                newAcount.beginBalance = 0
                accountsDictionary[name] = newAcount
            }
        }

        CoreData.app.saveData()

    }
    
    func simulateTransaction() {
        
        let fromAccount = Account()
        fromAccount.referenceTo(coreData: accountsDictionary["bofa"]!)
            
        let toAccount = Account()
        toAccount.referenceTo(coreData: accountsDictionary["grocery"]!)
        
        let yearsHistory = 1
        let components = Calendar.current.dateComponents([.day,.month,.year], from: Date())
        let year = components.year!
        let month = components.month!
        let day = components.day!
        
        createPeriodicTransactions(from: [fromAccount], to: [toAccount], title: ["Big C Mega Bangna", "Villa Paseo", "Tesco Online", "TOPS Mega", "Makro"], amount: [510,660,1520,245.50,2655,345,462.5], note: nil, url: nil, frequency: .month, multiple: 1, count: 3*yearsHistory, startDate: day, month: month, year: year, flexibleDate:0)
        
        CoreData.app.saveData()
    }
    
    func simulateDeleteTransaciton() {
        print("Simulate delete")
        let transactions = CoreData.app.allTransactionsInCoreData!
        let victim = transactions[0]
        CoreData.app.context.delete(victim)
        CoreData.app.saveData()
        
    }
    
    func simulateInsertTransaction() {
        print("Simulate insert")
        let transactions = CoreData.app.allTransactionsInCoreData!
        let sample = transactions[0]
        
        let newBorn = Transaction()
        newBorn.referenceTo(coreData: sample)
        newBorn.addToCoreData()
        CoreData.app.saveData()
        
    }
    
    func simulateEditTransaction() {
        print("Simulate edit")
        let transactions = CoreData.app.allTransactionsInCoreData!
        let victim = transactions[3]
        
        victim.note = "New note"
        
        let newAccount = SimulateData.app.accountsDictionary["chase"]!
        victim.replaceAccounts(at: 0, with: newAccount)
        CoreData.app.saveData()
        
    }
    
    
    func printAllAccountsCoreData() {        
        for account in CoreData.app.allAccountsInCoreData! {
            print("\(account.name ?? "No name")")
        }

    }
    
    func printAllTransactionsCoreData() {
        for transactionCD in CoreData.app.allTransactionsInCoreData! {
            let transaction = Transaction()
            transaction.referenceTo(coreData: transactionCD)
            
            let accounts = transaction.accounts ?? []
            let accountNames = accounts.map{$0.name!}

            print("\(transaction.date!) : \(transaction.title ?? "No Title") : \(accountNames)")
        }
        
    }
    
    func printAllMonthsInCoreDataFor(account: AccountCoreData) {
 
        for month in account.monthlyData?.array as! [MonthCoreData] {

            print("\(month.endDate?.description ?? "No Date") Flow: \(month.flow) Balance: \(month.balance)")

        }
        
        
        
        
    }
    
    func clearAllCoreData(){
        
        isClearingData = true
        
        let context = CoreData.app.context
        
        do {
            let result = try context.fetch(AccountCoreData.fetchRequest())
            for object in result {
                context.delete(object as! NSManagedObject)
            }
            
        } catch {
            print("Deleting Account failed: \(error)")
        }
        
        CoreData.app.saveData()
        
        isClearingData = false
        
    }
    
}






