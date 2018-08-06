//
//  ViewController.swift
//  goldbac
//
//  Created by adulphan youngmod on 24/7/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orange
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapOnView(sender:)))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
   
    }
    
    var steps:Int = 1
    var accountDictionary:[String:AccountCoreData] = [:]
    var transactionDictionary:[String:TransactionCoreData] = [:]
    
    @objc func handleTapOnView(sender: UITapGestureRecognizer) {
        
        print(Reachability.shared.isReachable)
//        action(steps: steps)
//        steps += 1
    }

    func action(steps:Int) {
        
        switch steps {
        case 1:
            
            let newAcount = AccountCoreData(context: CoreData.shared.context)
            newAcount.name = "Bofa"
            newAcount.type = Application.accountType.bank.rawValue
            newAcount.beginBalance = 0
            newAcount.endBalance = 0
            newAcount.recordID = UUID().uuidString
            accountDictionary[newAcount.name!] = newAcount
            CoreData.shared.saveData()
            
        case 2:
            
            let newAcount = AccountCoreData(context: CoreData.shared.context)
            newAcount.name = "Grocery"
            newAcount.type = Application.accountType.bank.rawValue
            newAcount.beginBalance = 0
            newAcount.endBalance = 0
            newAcount.recordID = UUID().uuidString
            accountDictionary[newAcount.name!] = newAcount
            CoreData.shared.saveData()
            
        case 3:
            
            let newTransaction = TransactionCoreData(context: CoreData.shared.context)
            newTransaction.title = "Tesco Lotus"
            newTransaction.recordID = UUID().uuidString
            newTransaction.date = Date().adjustedToAppCalendar
            newTransaction.fullImageRecordID = nil
            newTransaction.modified = Date()
            newTransaction.flowArray = [-500,500]
            newTransaction.note = nil
            newTransaction.thumbnailRecordID = nil
            newTransaction.url = "www.goldbac.com"
            
            let accountArray = [accountDictionary["Bofa"]!,accountDictionary["Grocery"]!]
            newTransaction.accounts = NSOrderedSet(array: accountArray)
            
            
            CoreData.shared.saveData()
            
        case 4:
            CoreData.shared.saveData()
            
            SimulateData.shared.printAllAccountsCoreData()
            SimulateData.shared.printAllTransactionsCoreData()
            SimulateData.shared.printAllMonthsInCoreDataFor(account: accountDictionary["Bofa"]!)
            SimulateData.shared.printAllMonthsInCoreDataFor(account: accountDictionary["Grocery"]!)
            SimulateData.shared.printBalanceFor(monthEnd: Date().monthEnd)
            
        default:
            print(steps)
        }
        
        print(steps)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

