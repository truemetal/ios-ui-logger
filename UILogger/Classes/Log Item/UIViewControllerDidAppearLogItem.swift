//
//  UIViewControllerDidAppearLogItem.swift
//  Pods-UILogger-Example
//
//  Created by Dan Pashchenko on 2/10/18.
//

import UIKit

public class UIViewControllerDidAppearLogItem: UILogItem {
    @objc public init(vc: UIViewController) {
        let resTitle: String?
        
        if let title = vc.title, let navTitle = vc.navigationItem.title { resTitle = "\(title) / \(navTitle)" }
        else if let title = vc.title { resTitle = title }
        else if let navTitle = vc.navigationItem.title { resTitle = navTitle }
        else { resTitle = nil }
        
        super.init(type: .viewControllerDidAppear, object: vc, title: resTitle)
    }
}
