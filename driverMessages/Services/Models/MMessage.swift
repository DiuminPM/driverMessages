//
//  MMessage.swift
//  driverMessages
//
//  Created by DiuminPM on 02.11.2021.
//

import UIKit

struct MMessage: Hashable {
    let content: String
    let senderId: String
    let senderUserName: String
    var sentDate: Date
    let id: String?
    
    
    init(user: MUser, content: String) {
        self.content = content
        senderId = user.id
        senderUserName = user.userName
        sentDate = Date()
        id = nil
    }
    
    var representation: [String : Any] {
        var rep: [String : Any] = [
            "created": sentDate,
            "senderId": senderId,
            "senderName": senderUserName,
            "content": content
        ]
        return rep

    }
}



