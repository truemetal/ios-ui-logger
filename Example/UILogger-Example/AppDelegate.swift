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
        UILogger.printToConsole = false
        
        NotificationCenter.default.addObserver(forName: UILogger.uiLogNotification, object: nil, queue: nil) { (n) in
            guard let logItem = n.object as? UILogItem else { return }
            // do something here with logItem
            print("received log item: \(UILoggerLaunchTimeHolder.appUptime()) \(logItem.descriptionDict)")
        }
        
        return true
    }
}
