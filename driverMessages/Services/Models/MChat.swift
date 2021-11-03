//
//  MChat.swift
//  driverMessages
//
//  Created by DiuminPM on 21.10.2021.
//

import UIKit
import Firebase

struct MChat: Hashable, Decodable {
    var friendUserName: String
    var friendAvatarStringURL: String
    var lastMessageContent: String
    var friendId: String
    
    var representation: [String : Any] {
        var rep = ["friendUserName" : friendUserName]
        rep["friendAvatarStringURL"] = friendAvatarStringURL
        rep["friendId"] = friendId
        rep["lastMessage"] = lastMessageContent
        return rep
    }
    
    init(friendUserName: String, friendAvatarStringURL: String, lastMessageContent: String, friendId: String) {
        self.friendUserName = friendUserName
        self.friendAvatarStringURL = friendAvatarStringURL
        self.lastMessageContent = lastMessageContent
        self.friendId = friendId
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let friendUserName = data["friendUserName"] as? String,
        let friendAvatarStringURL = data["friendAvatarStringURL"] as? String,
        let lastMessageContent = data["lastMessage"] as? String,
        let friendId = data["friendId"] as? String else { return nil }
        
        self.friendUserName = friendUserName
        self.friendAvatarStringURL = friendAvatarStringURL
        self.lastMessageContent = lastMessageContent
        self.friendId = friendId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(friendId)
    }
    
    static func == (lhs: MChat, rhs: MChat) -> Bool {
        return lhs.friendId == rhs.friendId
    }
    
}
