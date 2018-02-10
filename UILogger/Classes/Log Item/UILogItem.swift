//
//  UILogItem.swift
//  Pods-UILogger_Example
//
//  Created by Dan Pashchenko on 2/10/18.
//

import Foundation

public class UILogItem: NSObject {
    public let type: UILogItemActionType
    public let object: NSObject
    public let title: String?
    public let timestamp = Date()
    
    @objc public init(type: UILogItemActionType, object: NSObject, title: String?) {
        self.type = type
        self.object = object
        self.title = title
    }
    
    public lazy var descriptionDict: [String : String] = {
        var res = [
            "type" : type.description,
            "object" : String(describing: Mirror(reflecting: object).subjectType),
            ]
        
        if let titleProvider = object as? UILogTitleProvider, let title = titleProvider.uiLogTitle { res["title"] = title }
        else if let title = title { res["title"] = title }
        
        return res
    }()
}
