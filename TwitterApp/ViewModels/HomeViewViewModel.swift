//
//  HomeViewViewModel.swift
//  TwitterApp
//
//  Created by Enes Sancar on 8.07.2023.
//

import Foundation
import Combine
import FirebaseAuth

final class HomeViewViewModel: ObservableObject {
    
    @Published var user: TwitterUser?
    @Published var error: String?
    
    private var subscription: Set<AnyCancellable> = []

    func retreiveUser() {
        guard let id = Auth.auth().currentUser?.uid else { return }
        DatabaseManager.shared.collectionUsers(retreive: id)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] user in
                guard let self else { return }
                self.user = user
            }
            .store(in: &subscription)
    }
}
