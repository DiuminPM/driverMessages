//
//  UILabel + Extension.swift
//  driverMessages
//
//  Created by DiuminPM on 14.10.2021.
//

import Foundation
import UIKit

extension UILabel {
    convenience init(text: String,
                     font: UIFont? = .avenir20()
    ) {
        self.init()
        
        self.text = text
        self.font = font
    }
}
