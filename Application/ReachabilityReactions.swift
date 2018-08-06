//
//  ReachabilityReactions.swift
//  goldbac
//
//  Created by adulphan youngmod on 6/8/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

import Foundation

extension Reachability {
    
    @objc func reachabilityDidChange(_ notification: Notification) {
        if self.isReachable  {
            print("Connected to the Internet")
            Cloudkit.shared.proceedPendingsToCloudKit()
        } else {
            print("Disconnected to the Internet")
        }
    }


    
}






