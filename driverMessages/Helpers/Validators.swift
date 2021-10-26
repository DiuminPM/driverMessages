//
//  Validators.swift
//  driverMessages
//
//  Created by DiuminPM on 24.10.2021.
//

import UIKit

class Validators {
    static func isFilled(email: String?, password: String?, confirmPassword: String?) -> Bool {
        guard let password = password,
              let confirmPassword = confirmPassword,
              let email = email,
              password != "",
              confirmPassword != "",
              email != "" else { return false }
        return true
    }
    
    static func isFilled(userName: String?, description: String?, sex: String?) -> Bool {
        guard let description = description,
              let sex = sex,
              let userName = userName,
              description != "",
              sex != "",
              userName != "" else { return false }
        return true
    }
    
    static func isSimpleEmail(_ email: String) -> Bool {
        let emailRegEx = "^.+@.+\\..{2,}$"
        return check(text: email, regEX: emailRegEx)
    }
    
    private static func check(text: String, regEX: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEX)
        return predicate.evaluate(with: text)
    }
}


