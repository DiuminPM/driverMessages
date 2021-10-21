//
//  MUser.swift
//  driverMessages
//
//  Created by DiuminPM on 21.10.2021.
//

import UIKit

struct MUser: Hashable, Decodable {
    var userName: String
    var avatarStringURL: String
    var id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MUser, rhs: MUser) -> Bool {
        return lhs.id == rhs.id
    }
    
}
