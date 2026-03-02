//
//  LoginView.swift
//  CalorieTracker
//
//  Created by Matthew Saeed on 2/25/26.
//
import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    
    @State private var email = ""
    @State private var password = ""
    
    @State private var goCreate = false
    @State private var goReset = false
    @State private var goHome = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                
                Text("CalorieTracker")
                    .font(.largeTitle)
                    .bold()
                
                TextField("Email", text: $email)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled(true)
                    .textFieldStyle(.roundedBorder)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                
                if !authVM.message.isEmpty {
                    Text(authVM.message)
                        .font(.footnote)
                }
                
                Button("Sign In") {
                    Task {
                        await authVM.signIn(email: email, password: password)
                        if authVM.user != nil {
                            goHome = true
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(authVM.isBusy)
                
                HStack {
                    Button("Create Account") {
                        goCreate = true
                    }
                    Spacer()
                    Button("Forgot Password?") {
                        goReset = true
                    }
                }
                .font(.footnote)
            }
            .padding()
            .navigationDestination(isPresented: $goCreate) {
                CreateAccountView()
            }
            .navigationDestination(isPresented: $goReset) {
                ResetPasswordView()
            }
            .navigationDestination(isPresented: $goHome) {
                HomeView()
            }
        }
    }
}
