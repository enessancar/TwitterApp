//
//  DatabaseManager.swift
//  TwitterApp
//
//  Created by Enes Sancar on 7.07.2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestoreCombineSwift
import Combine

class DatabaseManager {
    static let shared = DatabaseManager()
    private init() {}
    
    let db = Firestore.firestore()
    let userPath: String = "users"
    
    func collectionUsers(add user: User) -> AnyPublisher<Bool, Error> {
        let twitterUser = TwitterUser(from: user)
        return db.collection(userPath).document(twitterUser.id).setData(from: twitterUser)
            .map { _ in
                return true
            }.eraseToAnyPublisher()
    }
}
