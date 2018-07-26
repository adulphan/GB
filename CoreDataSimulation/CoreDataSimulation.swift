//
//  CoreDataSimulation.swift
//  goldbac
//
//  Created by adulphan youngmod on 26/7/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataSimulation {
    
    static let main = CoreDataSimulation()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let components = Calendar.current.dateComponents([.day,.month,.year], from: Date())
    var allAccounts: [Account] = []

}











