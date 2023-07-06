//
//  AuthManager.swift
//  TwitterApp
//
//  Created by Enes Sancar on 6.07.2023.
//

import Foundation
import Firebase
import FirebaseAuthCombineSwift
import Combine

class AuthManager {
    static let shared = AuthManager()
    private init() {}
    
    func registerUser(email: String, password: String) -> AnyPublisher<User, Error> {
        Auth.auth().createUser(withEmail: email, password: password)
            .map(\.user)
            .eraseToAnyPublisher()
    }
}
