//
//  SimulateTransaction.swift
//  goldbac
//
//  Created by adulphan youngmod on 25/7/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension CoreDataSimulation {
    
    func simulateTransaction() {
        
        allAccounts = CoreData.main.allAccountsInCoreData!
        
        simulateGroceryTransaction(yearsHistory: 1)
        simulateUtilityTransaction(yearsHistory: 1)
        simulateOtherExpenseTransaction(yearsHistory: 1)
//        
        simulateIncome(yearsHistory: 1)

    }
    
    func simulateIncome(yearsHistory:Int) {
 
        let year = components.year!
        let month = components.month!
        let day = components.day!
        
        let mainBankAccount = allAccounts.filter { (account) -> Bool in
            account.name == "Bofa"
        }
        
        let salaryAccount = allAccounts.filter { (account) -> Bool in
            account.name == "Salary"
        }
        
        CoreDataSimulation.main.createPeriodicTransactions(from: salaryAccount, to: mainBankAccount, title: ["Monthly salary"], amount: [150000], note: nil, url: nil, frequency: .month, multiple: 1, count: 12*yearsHistory, startDate: day-5, month: month, year: year, flexibleDate:0)

        let interestAccount = allAccounts.filter { (account) -> Bool in
            account.name == "Interests"
        }
        
        CoreDataSimulation.main.createPeriodicTransactions(from: interestAccount, to: mainBankAccount, title: ["Interest Income from savings"], amount: [10000], note: nil, url: nil, frequency: .month, multiple: 1, count: 12*yearsHistory, startDate: day-5, month: month, year: year, flexibleDate:0)

    }
    
    func simulateOtherExpenseTransaction(yearsHistory:Int) {
        
        let year = components.year!
        let month = components.month!
        let day = components.day!
        
        let fromAccounts = allAccounts.filter { (account) -> Bool in
            account.type == CoreData.AccountType.card.rawValue ||
                account.type == CoreData.AccountType.bank.rawValue
        }
        
        let medicalAccount = allAccounts.filter { (account) -> Bool in
            account.name == "Medical"
        }

        CoreDataSimulation.main.createPeriodicTransactions(from: fromAccounts, to: medicalAccount, title: ["Mom Medical", "Vitamin D3", "Vitamin B12", "Health checkup", "First-aid supply", "Stomach ache", "Head ache"], amount: [210,260,520,345.50,355,145,162,205], note: nil, url: nil, frequency: .month, multiple: 3, count: 4*yearsHistory, startDate: day-60, month: month, year: year, flexibleDate:10)

        let applianceAccount = allAccounts.filter { (account) -> Bool in
            account.name == "Appliance"
        }

        CoreDataSimulation.main.createPeriodicTransactions(from: fromAccounts, to: applianceAccount, title: ["Blender", "Samsung Refridgerator", "Oven", "Washing machine", "Grass trimmer", "Helicopter", "Electrical outlets", "Lamps", "Microwave oven", "50 inch LED TV", "Cannon printer"], amount: [6610,8860,7920,2445.50,3600,7840,9185,8009], note: nil, url: nil, frequency: .month, multiple: 2, count: 6*yearsHistory, startDate: day-20, month: month, year: year, flexibleDate:10)

        let familyAccount = allAccounts.filter { (account) -> Bool in
            account.name == "Family"
        }

        CoreDataSimulation.main.createPeriodicTransactions(from: fromAccounts, to: familyAccount, title: ["Japan Vacation", "Home Gathering Songkran", "Funeral", "Wedding of the Sis", "Birthday of the niece", "Large Eatout Chrismas", "Trip to Indonesia", "New Year Party"], amount: [5200,2200,3020,4005.50,5005,7045,3102,8605], note: nil, url: nil, frequency: .month, multiple: 3, count: 4*yearsHistory, startDate: day-36, month: month, year: year, flexibleDate:10)

        let homeAccount = allAccounts.filter { (account) -> Bool in
            account.name == "Home"
        }

        CoreDataSimulation.main.createPeriodicTransactions(from: fromAccounts, to: homeAccount, title: ["Sofa sets", "Dishes", "Kitchenwares", "Lightbulbs and ther electrics", "Coffee table", "Fans", "Beds, cusions, and pillows", "Throws"], amount: [4210,2260,3520,4345.50,3355,7145,3162,8205], note: nil, url: nil, frequency: .month, multiple: 1, count: 12*yearsHistory, startDate: day-15, month: month, year: year, flexibleDate:10)

        let carAccount = allAccounts.filter { (account) -> Bool in
            account.name == "Car"
        }

        CoreDataSimulation.main.createPeriodicTransactions(from: fromAccounts, to: carAccount, title: ["Car repair", "Checkup","Change spare parts", "New tires x 4", "Glass broke", "Engine oil", "Gear oil", "Insurance", "Yearly registration"], amount: [5200,2200,3020,4005.50,5005,7045,3102,8605], note: nil, url: nil, frequency: .month, multiple: 3, count: 4*yearsHistory, startDate: day-30, month: month, year: year, flexibleDate:10)


    }
    
    func simulateUtilityTransaction(yearsHistory:Int) {

        let year = components.year!
        let month = components.month!
        let day = components.day!
        
        let fromAccounts = allAccounts.filter { (account) -> Bool in
                account.type == CoreData.AccountType.card.rawValue ||
                account.type == CoreData.AccountType.bank.rawValue
        }

        let utilityAccounts = allAccounts.filter { (account) -> Bool in
            account.name == "Utility"
        }

        CoreDataSimulation.main.createPeriodicTransactions(from: fromAccounts, to: utilityAccounts, title: ["Monthly electricity"], amount: [510,660,520,645.50,655,745,662,705], note: nil, url: nil, frequency: .month, multiple: 1, count: 12*yearsHistory, startDate: day-5, month: month, year: year, flexibleDate:0)

        CoreDataSimulation.main.createPeriodicTransactions(from: fromAccounts, to: utilityAccounts, title: ["Monthly water"], amount: [510,660,520,645.50,655,745,662,705], note: nil, url: nil, frequency: .month, multiple: 1, count: 12*yearsHistory, startDate: day, month: month, year: year, flexibleDate:0)
        
        CoreDataSimulation.main.createPeriodicTransactions(from: fromAccounts, to: utilityAccounts, title: ["TOT Fiber Broadband"], amount: [750], note: nil, url: nil, frequency: .month, multiple: 1, count: 12*yearsHistory, startDate: day-10, month: month, year: year, flexibleDate:0)


        let subscriptionAccount = allAccounts.filter { (account) -> Bool in
            account.name == "Subscription"
        }

        CoreDataSimulation.main.createPeriodicTransactions(from: fromAccounts, to: subscriptionAccount, title: ["Monthly NetFlix $10"], amount: [350], note: nil, url: nil, frequency: .month, multiple: 1, count: 12*yearsHistory, startDate: day-7, month: month, year: year, flexibleDate:0)



        let fuelAccount = allAccounts.filter { (account) -> Bool in
            account.name == "Fuel"
        }

        CoreDataSimulation.main.createPeriodicTransactions(from: fromAccounts, to: fuelAccount, title: ["Gasoline"], amount: [1010,860,1020,1145.1150,1055,1145,862,905], note: nil, url: nil, frequency: .day, multiple: 15, count: 24*yearsHistory, startDate: day-15, month: month, year: year, flexibleDate:3)

    }


    func simulateGroceryTransaction(yearsHistory:Int) {
        
        let components = Calendar.current.dateComponents([.day,.month,.year], from: Date())
        let year = components.year!
        let month = components.month!
        let day = components.day!
        
        let allAccounts = CoreData.main.allAccountsInCoreData!
        let fromAccounts = allAccounts.filter { (account) -> Bool in
            account.type == CoreData.AccountType.cash.rawValue ||
            account.type == CoreData.AccountType.card.rawValue ||
            account.type == CoreData.AccountType.bank.rawValue
        }

        let groceryAccount = allAccounts.filter { (account) -> Bool in
            account.name == "Grocery"
        } 
        
        CoreDataSimulation.main.createPeriodicTransactions(from: fromAccounts, to: groceryAccount, title: ["Big C Mega Bangna", "Villa Paseo", "Tesco Online", "TOPS Mega", "Makro"], amount: [510,660,1520,245.50,2655,345,462.5], note: nil, url: nil, frequency: .month, multiple: 1, count: 12*yearsHistory, startDate: day-5, month: month, year: year, flexibleDate:0)
        
        CoreDataSimulation.main.createPeriodicTransactions(from: fromAccounts, to: groceryAccount, title: ["Big C Mega Bangna", "Villa Paseo", "Tesco Online", "TOPS Mega", "Makro"], amount: [512,665,1500,250.50,55,350,588.5], note: nil, url: nil, frequency: .month, multiple: 1, count: 12*yearsHistory, startDate: day-5, month: month, year: year, flexibleDate:2)

        CoreDataSimulation.main.createPeriodicTransactions(from: fromAccounts, to: groceryAccount, title: ["Big C Mega Bangna", "Villa Paseo", "Tesco Online", "TOPS Mega", "Makro"], amount: [2120,1600,1500,2500,2500,3250,2088], note: nil, url: nil, frequency: .month, multiple: 1, count: 12*yearsHistory, startDate: day-5, month: month, year: year, flexibleDate:5)
        
        CoreDataSimulation.main.createPeriodicTransactions(from: fromAccounts, to: groceryAccount, title: ["Tesco", "Seven Eleven", "Fresh Market", "TOPS"], amount: [120,60,150,80,20,150,83], note: nil, url: nil, frequency: .day, multiple: 7, count: 52*yearsHistory, startDate: day, month: month, year: year, flexibleDate:1)
        
        let eatoutAccount = allAccounts.filter { (account) -> Bool in
            account.name == "Eatout"
        }
        
        CoreDataSimulation.main.createPeriodicTransactions(from: fromAccounts, to: eatoutAccount, title: ["MK Suki", "McDonald", "TacoBell", "Japanese Restaurant", "Italian Pizza", "StarBucks", "KFC", "Canteen", "Coffee World", "Steak House"], amount: [550,860,320,1070,1150,1055,845,562,945], note: nil, url: nil, frequency: .day, multiple: 3, count: 120*yearsHistory, startDate: day, month: month, year: year, flexibleDate:1)

    }
    



}
