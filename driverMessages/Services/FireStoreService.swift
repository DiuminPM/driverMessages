//
//  FireStoreService.swift
//  driverMessages
//
//  Created by DiuminPM on 25.10.2021.
//

import UIKit
import Firebase

class FireStoreService {
    static let shared = FireStoreService()
    
    let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("users")
    }
    
    func saveProfileWith(id: String, email: String, userName: String?, avatarImageString: String?, description: String?, sex: String?, completion: @escaping (Result<MUser, Error>) -> Void) {
        guard Validators.isFilled(userName: userName, description: description, sex: sex) else { completion(.failure(UserError.notFilled))
            return
        }
        let mUser = MUser(userName: userName!,
            email: email,
            avatarStringURL: "not exist",
            description: description!,
            sex: sex!,
            id: id)
        
        self.usersRef.document(mUser.id).setData(mUser.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(mUser))
            }
        }
    }
    
}
