//
//  HomeView.swift
//  CalorieTracker
//
//  Created by Matthew Saeed on 2/25/26.
//
import SwiftUI
import FirebaseAuth
struct HomeView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                if let email = authVM.user?.email {
                    Text("Welcome, \(email)")
                        .font(.headline)
                }
                
                CalorieView()
                
                Button("Sign Out") {
                    authVM.signOut()
                }
                .buttonStyle(.borderedProminent)
                .padding(.top)
            }
            .padding()
        }
    }
}

