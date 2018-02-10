//
//  MyTableViewCell.swift
//  UILogger-Example
//
//  Created by Dan Pashchenko on 2/10/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import UILogger

class MyTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
}

extension MyTableViewCell: UILogTitleProvider {
    var uiLogTitle: String? { return lblTitle.text }
}
