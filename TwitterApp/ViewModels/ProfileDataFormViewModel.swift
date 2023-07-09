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
    
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published var displayName: String?
    @Published var username: String?
    @Published var bio: String?
    @Published var avatarPath: String?
    @Published var imageData: UIImage?
    @Published var isFormValid: Bool = false
    @Published var url: URL?
    
    @Published var error: String = ""
    
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
    
    func uploadAvatar() {
        
        let randomID = UUID().uuidString
        guard let imageData = imageData?.jpegData(compressionQuality: 0.5) else { return
        }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        StoreManager.shared.uploadProfilePhoto(with: randomID, image: imageData, metaData: metaData)
            .flatMap({ metaData in
                StoreManager.shared.getDownloadUrl(for: metaData.path)
            })
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] url in
                guard let self else { return }
                self.url = url
            }
            .store(in: &subscriptions)
    }
}

