//
//  StoreManager.swift
//  TwitterApp
//
//  Created by Enes Sancar on 9.07.2023.
//

import Foundation
import Combine
import FirebaseStorageCombineSwift
import FirebaseStorage

enum FireStorageError: Error {
    case invalidImageID
}

final class StoreManager {
    static let shared = StoreManager()
    private init() {}
    
    let storage = Storage.storage()
    
    func getDownloadUrl(for id: String?) -> AnyPublisher<URL, Error> {
        guard let id = id else {
            return Fail(error: FireStorageError.invalidImageID)
                .eraseToAnyPublisher()
        }
        return storage
            .reference(withPath: id)
            .downloadURL()
            .eraseToAnyPublisher()
    }
    
    func uploadProfilePhoto(with randomID: String, image: Data, metaData: StorageMetadata) -> AnyPublisher<StorageMetadata, Error> {
        
        return storage
            .reference()
            .child("images/\(randomID).jpg")
            .putData(image, metadata: metaData)
            .eraseToAnyPublisher()
    }
}
