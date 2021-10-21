//
//  SelfConfiguringCell.swift
//  driverMessages
//
//  Created by DiuminPM on 20.10.2021.
//

import Foundation

protocol SelfConfiguringCell {
    static var reuseId: String { get }
    func configure<U: Hashable>(with value: U)
}
