//
//  Transaction+CoreDataClass.swift
//  goldbac
//
//  Created by adulphan youngmod on 24/7/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//
//

import Foundation
import CoreData


public class Transaction: NSManagedObject {

    public override func didSave() {
        super.didSave()

        if self.isDeleted {

            print("\(self.recordID) is deleted")

        } else if self.isUpdated {

            print("\(self.recordID) is updated")

        } else if self.isInserted {

            print("\(self.recordID) is inserted")
            
            self.updateBalance()

        } else if self.isFault {

            print("\(self.recordID) is fault")
        } else {

            print("\(self.recordID) is doing sth else")
        }


    }

}












