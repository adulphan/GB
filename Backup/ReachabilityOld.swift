//
//  Reachability.swift
//  goldbac
//
//  Created by adulphan youngmod on 5/8/18.
//  Copyright © 2018 goldbac Inc. All rights reserved.
//

//import Foundation
//import UIKit
//import SystemConfiguration
//
//
//let ReachabilityDidChangeNotificationName = "ReachabilityDidChangeNotification"
//
//enum ReachabilityStatus {
//    case notReachable
//    case reachableViaWiFi
//    case reachableViaWWAN
//}
//
//public class Reachability: NSObject {
//    
//    private var networkReachability: SCNetworkReachability?
//    
//    init?(hostName: String) {
//        networkReachability = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, (hostName as NSString).utf8String!)
//        super.init()
//        if networkReachability == nil {
//            return nil
//        }
//    }
//    
//    init?(hostAddress: sockaddr_in) {
//        var address = hostAddress
//        
//        guard let defaultRouteReachability = withUnsafePointer(to: &address, {
//            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
//                SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, $0)
//            }
//        }) else {
//            return nil
//        }
//        
//        networkReachability = defaultRouteReachability
//        
//        super.init()
//        if networkReachability == nil {
//            return nil
//        }
//    }
//    
//    static func networkReachabilityForInternetConnection() -> Reachability? {
//        var zeroAddress = sockaddr_in()
//        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
//        zeroAddress.sin_family = sa_family_t(AF_INET)
//        return Reachability(hostAddress: zeroAddress)
//    }
//    
//    static func networkReachabilityForLocalWiFi() -> Reachability? {
//        var localWifiAddress = sockaddr_in()
//        localWifiAddress.sin_len = UInt8(MemoryLayout.size(ofValue: localWifiAddress))
//        localWifiAddress.sin_family = sa_family_t(AF_INET)
//        // IN_LINKLOCALNETNUM is defined in <netinet/in.h> as 169.254.0.0 (0xA9FE0000).
//        localWifiAddress.sin_addr.s_addr = 0xA9FE0000
//        
//        return Reachability(hostAddress: localWifiAddress)
//    }
//    
//    private var notifying: Bool = false
//    
//    
//    func startNotifier() {
//        
//        guard notifying == false else { return }
//        
//        var context = SCNetworkReachabilityContext()
//        context.info = UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque())
//        
//        guard let reachability = networkReachability, SCNetworkReachabilitySetCallback(reachability, { (target: SCNetworkReachability, flags: SCNetworkReachabilityFlags, info: UnsafeMutableRawPointer?) in
//            if let currentInfo = info {
//                let infoObject = Unmanaged<AnyObject>.fromOpaque(currentInfo).takeUnretainedValue()
//                if infoObject is Reachability {
//                    let networkReachability = infoObject as! Reachability
//                    NotificationCenter.default.post(name: Notification.Name(rawValue: ReachabilityDidChangeNotificationName), object: networkReachability)
//                }
//            }
//        }, &context) == true else { return }
//        
//        guard SCNetworkReachabilityScheduleWithRunLoop(reachability, CFRunLoopGetCurrent(), CFRunLoopMode.defaultMode.rawValue) == true else { return }
//        
//        notifying = true
//        //return notifying
//    }
//    
//    func stopNotifier() {
//        if let reachability = networkReachability, notifying == true {
//            SCNetworkReachabilityUnscheduleFromRunLoop(reachability, CFRunLoopGetCurrent(), CFRunLoopMode.defaultMode as! CFString)
//            notifying = false
//        }
//    }
//    
//    deinit {
//        stopNotifier()
//    }
//    
//    private var flags: SCNetworkReachabilityFlags {
//        
//        var flags = SCNetworkReachabilityFlags(rawValue: 0)
//        
//        if let reachability = networkReachability, withUnsafeMutablePointer(to: &flags, { SCNetworkReachabilityGetFlags(reachability, UnsafeMutablePointer($0)) }) == true {
//            return flags
//        }
//        else {
//            return []
//        }
//    }
//    
//    
//    var currentReachabilityStatus: ReachabilityStatus {
//
//
//        if flags.contains(.reachable) == false {
//            // The target host is not reachable.
//            return .notReachable
//        }
//        else if flags.contains(.isWWAN) == true {
//            // WWAN connections are OK if the calling application is using the CFNetwork APIs.
//            return .reachableViaWWAN
//        }
//        else if flags.contains(.connectionRequired) == false {
//            // If the target host is reachable and no connection is required then we'll assume that you're on Wi-Fi...
//            return .reachableViaWiFi
//        }
//        else if (flags.contains(.connectionOnDemand) == true || flags.contains(.connectionOnTraffic) == true) && flags.contains(.interventionRequired) == false {
//            // The connection is on-demand (or on-traffic) if the calling application is using the CFSocketStream or higher APIs and no [user] intervention is needed
//            return .reachableViaWiFi
//        }
//        else {
//            return .notReachable
//        }
//    }
//    
//    var isReachable: Bool {
//        
//        switch currentReachabilityStatus {
//        case .notReachable:
//            return false
//        case .reachableViaWiFi, .reachableViaWWAN:
//            return true
//        }
//    }
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    //static let shared = Reachability()
//    
//
//    
//    
//    
//    
//    
//
////    func isConnectedToNetwork() -> Bool {
////        guard let flags = getFlags() else { return false }
////        let isReachable = flags.contains(.reachable)
////        let needsConnection = flags.contains(.connectionRequired)
////        return (isReachable && !needsConnection)
////    }
////
////    func getFlags() -> SCNetworkReachabilityFlags? {
////        guard let reachability = ipv4Reachability() ?? ipv6Reachability() else {
////            return nil
////        }
////        var flags = SCNetworkReachabilityFlags()
////        if !SCNetworkReachabilityGetFlags(reachability, &flags) {
////            return nil
////        }
////        return flags
////    }
////
////    func ipv6Reachability() -> SCNetworkReachability? {
////        var zeroAddress = sockaddr_in6()
////        zeroAddress.sin6_len = UInt8(MemoryLayout<sockaddr_in>.size)
////        zeroAddress.sin6_family = sa_family_t(AF_INET6)
////
////        return withUnsafePointer(to: &zeroAddress, {
////            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
////                SCNetworkReachabilityCreateWithAddress(nil, $0)
////            }
////        })
////    }
////
////    func ipv4Reachability() -> SCNetworkReachability? {
////        var zeroAddress = sockaddr_in()
////        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
////        zeroAddress.sin_family = sa_family_t(AF_INET)
////
////        return withUnsafePointer(to: &zeroAddress, {
////            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
////                SCNetworkReachabilityCreateWithAddress(nil, $0)
////            }
////        })
////    }
//    
//
//    
//    
////    func connectedToNetwork() -> Bool {
////
////        var zeroAddress = sockaddr_in()
////        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
////        zeroAddress.sin_family = sa_family_t(AF_INET)
////
////        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
////            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
////                SCNetworkReachabilityCreateWithAddress(nil, $0)
////            }
////        }) else {
////            return false
////        }
////
////        var flags: SCNetworkReachabilityFlags = []
////        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
////            return false
////        }
////
////        let isReachable = flags.contains(.reachable)
////        let needsConnection = flags.contains(.connectionRequired)
////
////        return (isReachable && !needsConnection)
////    }
//    
//}
