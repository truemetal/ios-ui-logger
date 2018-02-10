//
//  MyCollectionViewCell.swift
//  UILogger-Example
//
//  Created by Dan Pashchenko on 2/10/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import UILogger

class MyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblTitle: UILabel!
}

extension MyCollectionViewCell: UILogTitleProvider {
    var uiLogTitle: String? { return lblTitle.text }
}
