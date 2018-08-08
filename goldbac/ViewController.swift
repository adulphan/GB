//
//  ViewController.swift
//  goldbac
//
//  Created by adulphan youngmod on 24/7/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    static let shared = ViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = "Accounts"
        navigationController?.isToolbarHidden = false
        createToolbar()
        Cloudkit.shared.tableView = tableView
 
    }
    
    func createToolbar() {

        let insertButton = UIBarButtonItem(title: "Insert", style: .plain, target: self, action: #selector(handleInsertButton(sender:)))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let syncButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(handleSyncButton(sender:)))
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(handleEditButton(sender:)))
        toolbarItems = [insertButton, spaceButton, editButton, spaceButton, syncButton]

    }
    
    @objc func handleInsertButton(sender: UIButton) {
        let newAcount = AccountCoreData(context: CoreData.shared.context)
        newAcount.name = "Bofa"
        newAcount.type = Application.accountType.bank.rawValue
        newAcount.beginBalance = 0
        newAcount.endBalance = 0
        newAcount.modified = Date()
        newAcount.recordID = UUID().uuidString
        accountDictionary[newAcount.name!] = newAcount
        CoreData.shared.saveData()
        tableView.insertRows(at: [IndexPath(item: 0, section: 0)], with: .automatic)

    }
    
    @objc func handleSyncButton(sender: UIButton) {
        Cloudkit.shared.fetchChanges()
        tableView.reloadData()        
    }
    
    @objc func handleEditButton(sender: UIButton) {
        let allAccounts = CoreData.shared.allAccountsInCoreData!
        if let first = allAccounts.first {
            first.modified = Date()
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let accounts = CoreData.shared.allAccountsInCoreData!
        return accounts.count
    }
    
    
    let cellId = "cellId"
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: cellId)
        let accounts = CoreData.shared.allAccountsInCoreData!
        let account = accounts[indexPath.item]
        cell.textLabel?.text = "\(account.modified?.description ?? "No Date") : \(account.recordID?.description ?? "No ID")"
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let accounts = CoreData.shared.allAccountsInCoreData!
        let account = accounts[indexPath.item]
        CoreData.shared.context.delete(account)
        CoreData.shared.saveData()
        tableView.deleteRows(at: [indexPath], with: .automatic)

    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    var steps:Int = 1
    var accountDictionary:[String:AccountCoreData] = [:]
    var transactionDictionary:[String:TransactionCoreData] = [:]
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
            
           let allAccounts = CoreData.shared.allAccountsInCoreData!
           CoreData.shared.context.delete(allAccounts[0])
            
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
            
            
            CoreData.shared.saveData()
            
        case 4:
            let allAccounts = CoreData.shared.allAccountsInCoreData!
            CoreData.shared.context.delete(allAccounts[0])
            
            CoreData.shared.saveData()
            
            SimulateData.shared.printAllAccountsCoreData()
            SimulateData.shared.printAllTransactionsCoreData()
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












