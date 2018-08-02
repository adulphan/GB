//
//  NumberExtensions.swift
//  goldbac
//
//  Created by adulphan youngmod on 31/7/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation
import UIKit

extension Double {

    func roundedDown(digit: Int) -> Double {
        let divisor = pow(10.0, Double(digit))
        return floor(self * divisor) / divisor
    }
    
    func rounded(digit: Int) -> Double {
        let divisor = pow(10.0, Double(digit))
        return (self * divisor).rounded() / divisor
    }
    
    
}
