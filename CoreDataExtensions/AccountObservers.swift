//
//  AccountObservers.swift
//  goldbac
//
//  Created by adulphan youngmod on 5/8/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation
import CoreData

extension AccountCoreData {

    public override func didSave() {
        super.didSave()
        
        if isInserted {
            Cloudkit.shared.saveToCloudKit(account: self)
        }
        
        if isDeleted {
            Cloudkit.shared.deleteFromCloudKit(account: self)
        }

    }

}





