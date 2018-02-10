//
//  UILogger.swift
//  Pods-UILogger_Example
//
//  Created by Dan Pashchenko on 2/10/18.
//

import Foundation

@objc public class UILogger: NSObject {
    @objc public static let uiLogNotification = Notification.Name("UILogger uiLogNotification")
    public static var printToConsole: Bool = true
    
    @objc public class func postLogItem(logItem: UILogItem) {
        if printToConsole { print(logItem: logItem) }
        NotificationCenter.default.post(name: uiLogNotification, object: logItem)
    }
    
    private class func print(logItem: UILogItem) {
        let timestamp = logItem.timestamp.timeIntervalSince(UILoggerLaunchTimeHolder.launchTime())
        let timestampStr = NSString(format: "%.3f", timestamp)
        Swift.print("UI Log: \(timestampStr)s \(logItem.descriptionDict)")
    }
}
