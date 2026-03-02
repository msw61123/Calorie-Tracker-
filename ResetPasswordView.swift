//
//  ResetPasswordView.swift
//  CalorieTracker
//
//  Created by Matthew Saeed on 2/25/26.
//
import SwiftUI

struct ResetPasswordView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var email = ""
    
    var body: some View {
        VStack(spacing: 16) {
            
            Text("Reset Password")
                .font(.title)
                .bold()
            
            TextField("Enter your email", text: $email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .autocorrectionDisabled(true)
                .textFieldStyle(.roundedBorder)
            
            if !authVM.message.isEmpty {
                Text(authVM.message)
                    .font(.footnote)
            }
            
            Button("Send Reset Email") {
                Task {
                    await authVM.sendPasswordReset(email: email)
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
