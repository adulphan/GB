//
//  TransactionObservers.swift
//  goldbac
//
//  Created by adulphan youngmod on 4/8/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation
import CoreData

extension TransactionCoreData {

    public override func willSave() {
        super.willSave()
        if isUpdated { wasUpdated = true }
    }
    
    public override func didSave() {
        super.didSave()
        
        if isInserted {
            insertFlows()
        }
        
        if isDeleted {
            deleteFlows()
        }
        
        if wasUpdated {
            updateFlows()
        }
        
        cacheThisCommittedTransaction()
        wasUpdated = false
        
    }
    
    
    
    
}
