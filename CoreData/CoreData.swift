//
//  CoreData.swift
//  goldbac
//
//  Created by adulphan youngmod on 25/7/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreData {

    static let main = CoreData()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext    

}
