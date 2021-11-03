//
//  SenderType.swift
//  driverMessages
//
//  Created by DiuminPM on 03.11.2021.
//

import Foundation
import MessageKit

struct Sender: SenderType {
    
    var senderId: String
    var displayName: String
    
    init(senderId: String, displayName: String) {
        self.senderId = senderId
        self.displayName = displayName
    }
}
