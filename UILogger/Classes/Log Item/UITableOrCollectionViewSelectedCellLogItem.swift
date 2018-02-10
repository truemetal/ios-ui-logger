//
//  UITableOrCollectionViewSelectedCellLogItem.swift
//  UILogger
//
//  Created by Dan Pashchenko on 2/10/18.
//

import UIKit

public class UITableOrCollectionViewSelectedCellLogItem: UILogItem {
    public let parentVc: UIViewController?
    public let indexPath: IndexPath
    
    @objc public convenience init?(tableView: UITableView, indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return nil }
        self.init(cell: cell, tableOrCollectionView: tableView, indexPath: indexPath, type: .tableCellTap)
    }
    
    @objc public convenience init?(collectionView: UICollectionView, indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return nil }
        self.init(cell: cell, tableOrCollectionView: collectionView, indexPath: indexPath, type: .collectionCellTap)
    }
    
    init(cell: NSObject, tableOrCollectionView: UIView, indexPath: IndexPath, type: UILogItemActionType) {
        self.indexPath = indexPath
        parentVc = UIViewController.getFromResponder(responder: tableOrCollectionView)
        super.init(type: type, object: cell, title: nil)
        
        descriptionDict["indexPath"] = "(\(indexPath.section):\(indexPath.row))"
        if let vc = parentVc { descriptionDict["parentVc"] = String(describing: Mirror(reflecting: vc).subjectType) }
    }
}
