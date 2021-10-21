//
//  UIViewController + Extension.swift
//  driverMessages
//
//  Created by DiuminPM on 21.10.2021.
//

import UIKit

extension UIViewController {
    func configure<T: SelfConfiguringCell, U: Hashable>(collectionView: UICollectionView, cellType: T.Type, with value: U, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as?  T else {
            fatalError("Unable ti dequeue \(cellType)")
        }
        cell.configure(with: value)
        return cell
    }
}
