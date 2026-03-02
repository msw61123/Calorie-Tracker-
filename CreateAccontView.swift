//
//  CreateAccontView.swift
//  CalorieTracker
//
//  Created by Matthew Saeed on 2/25/26.
//
import SwiftUI

struct CreateAccountView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: 16) {
            
            Text("Create Account")
                .font(.title)
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
            
            Button("Create Account") {
                Task {
                    await authVM.createAccount(email: email, password: password)
                    if authVM.user != nil {
                        dismiss()
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(authVM.isBusy)
            
            Button("Back") {
                dismiss()
            }
        }
        .padding()
    }
}
