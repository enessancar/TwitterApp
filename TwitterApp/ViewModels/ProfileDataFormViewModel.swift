//
//  ProfileDataFormViewViewModel.swift
//  TwitterApp
//
//  Created by Enes Sancar on 8.07.2023.
//

import UIKit
import Combine
import FirebaseAuth
import FirebaseStorage

final class ProfileDataFormViewViewModel: ObservableObject {
    
    @Published var displayName: String?
    @Published var username: String?
    @Published var bio: String?
    @Published var avatarPath: String?
    @Published var imageData: UIImage?
    @Published var isFormValid: Bool = false
    
    
    func validateUserProfileForm() {
        guard
            let displayName = displayName,
            displayName.count > 2,
            let username = username,
            username.count > 2,
            let bio = bio,
            bio.count <= 160,
            imageData != nil else {
            isFormValid = false
            return
        }
        isFormValid = true
    }
}
