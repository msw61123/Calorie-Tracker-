//
//  AuthViewModel.swift
//  CalorieTracker
//
//  Created by Matthew Saeed on 2/25/26.
//
import Foundation
import Combine
import FirebaseAuth

@MainActor
final class AuthViewModel: ObservableObject {
    
    @Published var user: User?
    @Published var message: String = ""
    @Published var isBusy: Bool = false
    
    init() {
        self.user = Auth.auth().currentUser
    }
    
    func signIn(email: String, password: String) async {
        isBusy = true
        defer { isBusy = false }
        
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            user = result.user
            message = "Signed in!"
        } catch {
            message = error.localizedDescription
        }
    }
    
    func createAccount(email: String, password: String) async {
        isBusy = true
        defer { isBusy = false }
        
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            user = result.user
            message = "Account created!"
        } catch {
            message = error.localizedDescription
        }
    }
    
    func sendPasswordReset(email: String) async {
        isBusy = true
        defer { isBusy = false }
        
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
            message = "Password reset email sent."
        } catch {
            message = error.localizedDescription
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            user = nil
            message = "Signed out."
        } catch {
            message = error.localizedDescription
        }
    }
}
