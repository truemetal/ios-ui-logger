//
//  UILogItemActionType.swift
//  UILogger
//
//  Created by Dan Pashchenko on 2/10/18.
//

import Foundation

@objc public enum UILogItemActionType: Int {
    case controlAction, tableCellTap, collectionCellTap, viewControllerDidAppear
    
    var description: String {
        switch self {
        case .controlAction: return "control action"
        case .tableCellTap: return "table cell tap"
        case .collectionCellTap: return "collection cell tap"
        case .viewControllerDidAppear: return "viewDidAppear"
        }
    }
}
