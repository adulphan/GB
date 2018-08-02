//
//  dataTest.swift
//  UnitTest
//
//  Created by adulphan youngmod on 31/7/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import XCTest
@testable import goldbac

class dataTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    

    func testAccountsAndMoneyArray() {
        
        let allTransactions = CoreData.main.allTransactionsInCoreData!
        
        for transaction in allTransactions {
            
            let numberOfaccounts = transaction.accounts.count
            let numberOfMoney = transaction.moneyArray.count
            let sumOfMoney = transaction.moneyArray.reduce(0,+)
            
            let numberOfFromAccounts = transaction.fromAccounts.count
            let numberOfToAccounts = transaction.toAccounts.count
            
            let numberOfNegativeFlows = transaction.moneyArray.filter { (money) -> Bool in
                money < 0
            }.count
            
            let numberOfPositiveFlows = transaction.moneyArray.filter { (money) -> Bool in
                money > 0
            }.count
            
            let allAccounts = transaction.accounts.array as! [Account]
            
            for account in allAccounts {
                let duplicate = allAccounts.filter { (sample) -> Bool in
                    sample == account
                }.count
                
                XCTAssertEqual(duplicate, 1)
                XCTAssertEqual(duplicate, 1, "\(allAccounts.map{$0.name})")
                
            }
            
            XCTAssertEqual(numberOfaccounts, numberOfMoney, "\(allAccounts.map{$0.name}) : \(transaction.moneyArray)")
            XCTAssertEqual(sumOfMoney, 0, "\(transaction.date) : \(transaction.moneyArray)")
            XCTAssertEqual(numberOfFromAccounts, numberOfNegativeFlows, "\(allAccounts.map{$0.name}) : \(transaction.moneyArray)")
            XCTAssertEqual(numberOfToAccounts, numberOfPositiveFlows, "\(allAccounts.map{$0.name}) : \(transaction.moneyArray)")
            
            
        }
        
        
    }
    
    func testTransactionAndFows() {

        let allAccounts = CoreData.main.allAccountsInCoreData!
    
        for i in 0...allAccounts.count-1 {
    
            let account = allAccounts[i]
            let transactions = account.transactionArray
            
            if transactions.count == 0 {
                
                XCTAssertEqual(0, account.monthly?.count)
                
                continue
            }
            
            let earliestDate = transactions.first?.date
            let oldestDate = transactions.last?.date
            let numberOfMonths = DateFormat.main.calendar.dateComponents([.month], from: oldestDate!, to: earliestDate!).month!

            for i in 0...numberOfMonths {
    
                let monthEnd = DateFormat.main.calendar.date(byAdding: .month, value: -i, to: earliestDate!)?.monthEnd

                let transactionInSameMonth = transactions.filter { (transaction) -> Bool in
                    transaction.date.monthEnd == monthEnd
                }
                
                var totalMonthFlow:Double = 0
                for transaction in transactionInSameMonth{
                    totalMonthFlow += transaction.getMoneyFor(account: account)
                }
    
                let appGeneratedMonthly = account.monthlyArray.filter { (monthly) -> Bool in
                    monthly.endDate == monthEnd
                }.first
                
                let appGeneratedFlow = appGeneratedMonthly?.flow
                
                if transactionInSameMonth.count == 0 {
                    
                    if appGeneratedFlow != nil {
                        
                        XCTAssertEqual(0, appGeneratedFlow)
                        
                    }

                } else {
                    
                    XCTAssertEqual(totalMonthFlow.rounded(digit: 2), appGeneratedFlow?.rounded(digit: 2), "\(String(describing: monthEnd)) : \(account.name)")
                    
                }

            }
            
            //print(i)
        }

    }
    
    
    func testEditTransactions() {
        
        for i in 0...10 {

            let allTransactions = CoreData.main.allTransactionsInCoreData!

            let all = CoreData.main.allAccountsInCoreData!

            var allAccounts = all.filter({ (account) -> Bool in
                account.type != CoreData.AccountType.equity.rawValue ||
                account.type != CoreData.AccountType.debt.rawValue ||
                account.type != CoreData.AccountType.asset.rawValue
            })

            let randomTransaction = allTransactions[CoreDataSimulation.main.randomInt(min: 0, max: allTransactions.count-1)]
            let oldAcconts = randomTransaction.accounts.array as! [Account]

            for account in oldAcconts {
                let index =  allAccounts.index(of: account)
                allAccounts.remove(at: index!)
            }

            let randomAccount1 = allAccounts[CoreDataSimulation.main.randomInt(min: 0, max: allAccounts.count-1)]
            let index1 = allAccounts.index(of: randomAccount1)!
            allAccounts.remove(at: index1)

            let randomAccount2 = allAccounts[CoreDataSimulation.main.randomInt(min: 0, max: allAccounts.count-1)]
            let index2 = allAccounts.index(of: randomAccount2)!
            allAccounts.remove(at: index2)

            let randomAccount3 = allAccounts[CoreDataSimulation.main.randomInt(min: 0, max: allAccounts.count-1)]
            let index3 = allAccounts.index(of: randomAccount3)!
            allAccounts.remove(at: index3)

            let randomAccount4 = allAccounts[CoreDataSimulation.main.randomInt(min: 0, max: allAccounts.count-1)]
            let index4 = allAccounts.index(of: randomAccount4)!
            allAccounts.remove(at: index4)

            let moneyArray:[[Double]] = [ [-1,0.8,0.1,0.1], [-0.6,-0.2,-0.2,1], [-0.5,-0.5,0.8,0.2]]
            let randomMoneyArray:[Double] = moneyArray[CoreDataSimulation.main.randomInt(min: 0, max: moneyArray.count-1)].map{$0*1000}

            //    [-1000,600,200,200]
            let randomAccountArray = [randomAccount1, randomAccount2, randomAccount3, randomAccount4]
            let oldMoneyArray = randomTransaction.moneyArray

            var oldBalanceArray:[Double] = []
            for i in 0...oldAcconts.count-1 {
                let oldBalanceTakeOutMoney = (oldAcconts[i].monthlyArray.first?.balance)! - oldMoneyArray[i]
                oldBalanceArray.append(oldBalanceTakeOutMoney)
            }

            var oldBalanceForRandomArray:[Double] = []
            for i in 0...randomAccountArray.count-1 {
                let balanceTakeOutMoney = (randomAccountArray[i].monthlyArray.first?.balance ?? 0) + randomMoneyArray[i]
                oldBalanceForRandomArray.append(balanceTakeOutMoney)
            }

            randomTransaction.setValue(NSOrderedSet(array: randomAccountArray), forKey: "accounts")
            randomTransaction.moneyArray = randomMoneyArray
            let newDate = Calendar.current.date(byAdding: .month, value: -i, to: Date())
            randomTransaction.date = DateFormat.main.standardized(date: newDate!)

            CoreData.main.saveData()

            var newBalanceArray:[Double] = []
            for account in oldAcconts {
                let newBalance = account.monthlyArray.first?.balance
                newBalanceArray.append(newBalance!)
            }

            XCTAssertEqual(oldBalanceArray, newBalanceArray)

            var newBalanceArrayForRandom:[Double] = []
            for account in randomAccountArray {
                let newBalance = account.monthlyArray.first?.balance
                newBalanceArrayForRandom.append(newBalance!)
            }

            XCTAssertEqual(oldBalanceForRandomArray, newBalanceArrayForRandom)
        }

        //CoreDataSimulation.main.printAllTransactions()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
