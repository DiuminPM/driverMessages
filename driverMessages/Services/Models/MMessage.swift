//
//  MMessage.swift
//  driverMessages
//
//  Created by DiuminPM on 02.11.2021.
//

import UIKit
import Firebase

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
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let sentDate =  data["created"] as? Timestamp else { return nil }
        guard let senderId =  data["senderId"] as? String else { return nil }
        guard let senderName =  data["senderName"] as? String else { return nil }
        guard let content =  data["content"] as? String else { return nil }

        self.id = document.documentID
        self.sentDate = sentDate.dateValue()
        self.senderId = senderId
        self.senderUserName = senderName
        self.content = content
    }
    
    var representation: [String : Any] {
        let rep: [String : Any] = [
            "created": sentDate,
            "senderId": senderId,
            "senderName": senderUserName,
            "content": content
        ]
        return rep

    }
}


