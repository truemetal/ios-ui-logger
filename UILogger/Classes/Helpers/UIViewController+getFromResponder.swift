//
//  UIViewController+getFromResponder.swift
//  Pods-UILogger-Example
//
//  Created by Dan Pashchenko on 2/10/18.
//

import UIKit

extension UIViewController {
    class func getFromResponder(responder: UIResponder) -> UIViewController? {
        var vc: UIResponder? = responder
        while vc != nil {
            if vc is UIViewController { break }
            vc = vc?.next
        }
        return vc as? UIViewController
    }
}
