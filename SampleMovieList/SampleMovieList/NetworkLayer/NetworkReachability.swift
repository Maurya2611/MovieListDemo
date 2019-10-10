//
//  NetworkReachability.swift
//  SampleMovieList
//
//  Created by Chandresh on 10/10/19.
//  Copyright © 2019 Chandresh. All rights reserved.
//

import Foundation
import Reachability
class NetworkReachability: NSObject {
    var reachability: Reachability!
    // Create a singleton instance
    static let sharedInstance: NetworkReachability = { return NetworkReachability()}()
    override init() {
        super.init()
        
        // Initialise reachability
        reachability = Reachability()!
        
        // Register an observer for the network status
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(networkStatusChanged(_:)),
            name: .reachabilityChanged,
            object: reachability
        )
        
        do {
            // Start the network status notifier
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    @objc func networkStatusChanged(_ notification: Notification) {
        // Do something globally here!
    }
    
    static func stopNotifier() -> Void {
        do {
            // Stop the network status notifier
            try (NetworkReachability.sharedInstance.reachability).startNotifier()
        } catch {
            print("Error stopping notifier")
        }
    }
    // Network is reachable
    static func isInterNetExist() -> Bool {
        if (NetworkReachability.sharedInstance.reachability).connection != .none {
            return true
        }
        return false
    }
    // Network is reachable
    static func isReachable(completed: @escaping (NetworkReachability) -> Void) {
        if (NetworkReachability.sharedInstance.reachability).connection != .none {
            completed(NetworkReachability.sharedInstance)
        }
    }
    // Network is unreachable
    static func isUnreachable(completed: @escaping (NetworkReachability) -> Void) {
        if (NetworkReachability.sharedInstance.reachability).connection == .none {
            completed(NetworkReachability.sharedInstance)
        }
    }
    // Network is reachable via WWAN/Cellular
    static func isReachableViaWWAN(completed: @escaping (NetworkReachability) -> Void) {
        if (NetworkReachability.sharedInstance.reachability).connection == .cellular {
            completed(NetworkReachability.sharedInstance)
        }
    }
    // Network is reachable via WiFi
    static func isReachableViaWiFi(completed: @escaping (NetworkReachability) -> Void) {
        if (NetworkReachability.sharedInstance.reachability).connection == .wifi {
            completed(NetworkReachability.sharedInstance)
        }
    }
}
