//
//  UIControlActionLogItem.swift
//  UILogger
//
//  Created by Dan Pashchenko on 2/10/18.
//

import UIKit

public class UIControlActionLogItem: UILogItem {
    let target: NSObject
    let selector: Selector
    
    @objc public init(sender: NSObject, target: NSObject, selector: Selector) {
        var title: String?
        if let b = sender as? UIButton { title = b.title(for: .normal) }
        if let b = sender as? UIBarButtonItem { title = b.title }
        if let s = sender as? UISegmentedControl { title = s.titleForSegment(at: s.selectedSegmentIndex) }
        
        self.target = target
        self.selector = selector
        
        super.init(type: .controlAction, object: sender, title: title)
        
        descriptionDict["target"] = String(describing: Mirror(reflecting: target).subjectType)
        descriptionDict["selector"] = selector.description
    }
}
