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
        VStack(spacing: 16) {
            Text("Home")
                .font(.largeTitle)
                .bold()
            
            Text(authVM.user?.email ?? "No user email")
            
            Button("Sign Out") {
                authVM.signOut()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
