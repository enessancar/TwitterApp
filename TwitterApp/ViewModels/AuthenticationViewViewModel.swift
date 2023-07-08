//
//  RegisterViewViewModel.swift
//  TwitterApp
//
//  Created by Enes Sancar on 5.07.2023.
//

import Foundation
import Firebase
import Combine

final class AuthenticationViewViewModel: ObservableObject {
    
    @Published var email: String?
    @Published var password: String?
    @Published var isAuthenticationFormValid: Bool = false
    @Published var user: User?
    @Published var error: String?
    
    private var subscription: Set<AnyCancellable> = []
    
    func validateAuthenticationForm() {
        guard let email, let password else {
            isAuthenticationFormValid = false
            return
        } 
        isAuthenticationFormValid = isValidEmail(email) && password.count >= 8
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func createUser() {
        guard let email, let password else { return }
        AuthManager.shared.registerUser(email: email, password: password)
            .handleEvents(receiveOutput: { [weak self] user in
                self?.user = user
            })
            .sink { [weak self] completion in
                
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] user in
                guard let self else { return }
                self.createRecord(for: user)
            }
            .store(in: &subscription)
    }
    
    func createRecord(for user: User) {
        DatabaseManager.shared.collectionUsers(add: user)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { state in
                print("adding user database")
            }
            .store(in: &subscription)
    }
    
    func loginUser() {
        guard let email, let password else { return }
        AuthManager.shared.loginUser(email: email, password: password)
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
