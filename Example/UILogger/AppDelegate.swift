//
//  AppDelegate.swift
//  UILogger
//
//  Created by truemetal on 10/23/2017.
//  Copyright (c) 2017 truemetal. All rights reserved.
//

import UIKit
import UILogger

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UILogHelper.printToConsole = false
        
        NotificationCenter.default.addObserver(forName: UILogItem.uiLogNotification, object: nil, queue: nil) { (n) in
            guard let log = n.object as? UILogItem else { return }
            
            if log.type == .viewControllerDidAppear { print("view controller did appear: \(log.title ?? ""); obj: \(log.object)") }
            if log.type == .controlAction { print("ui control action: \(log.title ?? ""); obj: \(log.object)") }
        }
        
        return true
    }
}
