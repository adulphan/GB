//
//  Helper.swift
//  goldbac
//
//  Created by adulphan youngmod on 26/7/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation

extension SimulateData {
    
    func randomInt(min: Int, max: Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
}
