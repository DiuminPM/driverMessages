//
//  WaitingChatsNavigation.swift
//  driverMessages
//
//  Created by DiuminPM on 03.11.2021.
//

import Foundation

protocol WaitingChatsNavigation: class {
    func removeWaitingChat(chat: MChat)
    func chatToActive(chat: MChat)
}
