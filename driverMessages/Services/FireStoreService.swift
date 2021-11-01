//
//  FireStoreService.swift
//  driverMessages
//
//  Created by DiuminPM on 25.10.2021.
//

import UIKit
import Firebase
import FirebaseFirestore

class FireStoreService {
    static let shared = FireStoreService()
    
    let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("users")
    }
    
    func getUserData(user: User, completion: @escaping (Result<MUser, Error>) -> Void) {
        let docRef = usersRef.document(user.uid)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                guard let muser = MUser(document: document) else {
                    completion(.failure(UserError.cannotUnwrapToMUser))
                    return
                }
                completion(.success(muser))
            } else {
                completion(.failure(UserError.cannotGetUserInfo))
            }
        }
    }
    
    func saveProfileWith(id: String, email: String, userName: String?, avatarImage: UIImage?, description: String?, sex: String?, completion: @escaping (Result<MUser, Error>) -> Void) {
        guard Validators.isFilled(userName: userName, description: description, sex: sex) else { completion(.failure(UserError.notFilled))
            return
        }
        
        guard avatarImage != #imageLiteral(resourceName: "avatar-4") else {
            completion(.failure(UserError.photoNotExist))
            return
        }
        
        var mUser = MUser(userName: userName!,
            email: email,
            avatarStringURL: "not exist",
            description: description!,
            sex: sex!,
            id: id)
        
        StorageService.shared.upload(photo: avatarImage!) { result in
            switch result {
            
            case .success(let url):
                mUser.avatarStringURL = url.absoluteString
                self.usersRef.document(mUser.id).setData(mUser.representation) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(mUser))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
       
    }
    
}
