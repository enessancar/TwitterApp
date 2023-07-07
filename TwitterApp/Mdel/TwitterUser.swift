//
//  TwitterUser.swift
//  TwitterApp
//
//  Created by Enes Sancar on 7.07.2023.
//

import Foundation
import Firebase

struct TwitterUser: Codable {
    var id: String
    var displayName: String = ""
    var username: String = ""
    var followersCount: Double = 0
    var followingCount: Double = 0
    var createdOn: Date = Date()
    var bio: String = ""
    var avatarPath: String = ""
    var isUserOnboarded: Bool = false
    
    init(from user: User) {
        self.id = user.uid
    }
}
