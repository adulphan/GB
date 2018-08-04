//
//  Helper.swift
//  goldbac
//
//  Created by adulphan youngmod on 4/8/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension CoreData {

    func createAccountsFrom(coreData: [AccountCoreData]) -> [Account] {
        var accountArray:[Account] = []
        for data in coreData {
            let account = Account()
            account.referenceTo(coreData: data)
            accountArray.append(account)
        }
        return accountArray
    }

}



