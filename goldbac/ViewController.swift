//
//  ViewController.swift
//  goldbac
//
//  Created by adulphan youngmod on 24/7/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var reachability = Reachability()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orange
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapOnView(sender:)))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityDidChange(_:)), name: NSNotification.Name(rawValue: ReachabilityDidChangeNotificationName), object: nil)
        
        reachability.startNotifier()
        
        
    }
    
    var steps:Int = 1
    var accountDictionary:[String:AccountCoreData] = [:]
    var transactionDictionary:[String:TransactionCoreData] = [:]
    
    
    @objc func reachabilityDidChange(_ notification: Notification) {
        checkReachability()
        print("Reachability really did changes")
        
    }
    
    func checkReachability() {

        if reachability.isReachable  {
            view.backgroundColor = UIColor.green
        } else {
            view.backgroundColor = UIColor.red
        }
    }

    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        reachability.stopNotifier()
    }
    
    @objc func handleTapOnView(sender: UITapGestureRecognizer) {
        
        if reachability.isReachable  {
            print("Reachable")
        } else {
            print("Unreachable")
        }
        
        
        
        //print(Reachability().isConnectedToNetwork())
        
//
//        switch steps {
//        case 1:
//
//            let newAcount = AccountCoreData(context: CoreData.shared.context)
//            newAcount.name = "Bofa"
//            newAcount.type = Application.accountType.bank.rawValue
//            newAcount.beginBalance = 0
//            newAcount.endBalance = 0
//            newAcount.recordID = UUID().uuidString
//            accountDictionary[newAcount.name!] = newAcount
//            CoreData.shared.saveData()
//
//        case 2:
//
//            let newAcount = AccountCoreData(context: CoreData.shared.context)
//            newAcount.name = "Grocery"
//            newAcount.type = Application.accountType.bank.rawValue
//            newAcount.beginBalance = 0
//            newAcount.endBalance = 0
//            newAcount.recordID = UUID().uuidString
//            accountDictionary[newAcount.name!] = newAcount
//            CoreData.shared.saveData()
//
//        case 3:
//
//            let newTransaction = TransactionCoreData(context: CoreData.shared.context)
//            newTransaction.title = "Tesco Lotus"
//            newTransaction.recordID = UUID().uuidString
//            newTransaction.date = Date().adjustedToAppCalendar
//            newTransaction.fullImageRecordID = nil
//            newTransaction.modified = Date()
//            newTransaction.flowArray = [-500,500]
//            newTransaction.note = nil
//            newTransaction.thumbnailRecordID = nil
//            newTransaction.url = "www.goldbac.com"
//
//            let accountArray = [accountDictionary["Bofa"]!,accountDictionary["Grocery"]!]
//            newTransaction.accounts = NSOrderedSet(array: accountArray)
//
//
//            CoreData.shared.saveData()
//
//        case 4:
//            CoreData.shared.saveData()
//
//            SimulateData.shared.printAllAccountsCoreData()
//            SimulateData.shared.printAllTransactionsCoreData()
//            SimulateData.shared.printAllMonthsInCoreDataFor(account: accountDictionary["Bofa"]!)
//            SimulateData.shared.printAllMonthsInCoreDataFor(account: accountDictionary["Grocery"]!)
//            SimulateData.shared.printBalanceFor(monthEnd: Date().monthEnd)
//
//        default:
//            print(steps)
//        }
//
//        print(steps)
//        steps += 1
//
//

    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

