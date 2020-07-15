//
//  CollectionViewUtilities.swift
//  AxxessChallenge
//
//  Created by Nabil Kazi on 15/07/20.
//  Copyright © 2020 Nabil Kazi. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func applyChanges(deletions: [Int], insertions: [Int], updates: [Int]) {
        performBatchUpdates({
            deleteItems(at: deletions.map(IndexPath.fromRow))
            insertItems(at: insertions.map(IndexPath.fromRow))
            reloadItems(at: updates.map(IndexPath.fromRow))
        }, completion: nil)
    }
}
