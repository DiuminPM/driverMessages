//
//  UIImageView + Extension.swift
//  driverMessages
//
//  Created by DiuminPM on 14.10.2021.
//

import Foundation
import UIKit

extension UIImageView {
    convenience init(image: UIImage?, contentMode: UIView.ContentMode) {
        self.init()
        
        self.image = image
        self.contentMode = contentMode
    }
}
