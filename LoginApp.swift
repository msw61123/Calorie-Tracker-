import SwiftUI
import FirebaseCore
import FirebaseAuth

@main
struct MyApp: App
{
    init() {
           FirebaseApp.configure()
       }
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var message = ""
    @State private var isBusy = false
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Login")
                .font(.largeTitle)
                .bold()
            
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            Button("Create Account") {
                            Task { await createAccount() }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
            Button("Create Account") {
                            Task { await createAccount() }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
            
            Button("Sign In") {
                if email == "admin" && password == "1234" {
                    message = "Login Successful"
                } else {
                    message = "Invalid Password"
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)
            
            Text(message)
                .foregroundColor(.gray)
        }
        .padding()
    }
    private func signIn() async {
            do {
                _ = try await Auth.auth().signIn(withEmail: email, password: password)
                message = "Login Successful "
            } catch {
                message = error.localizedDescription
            }
        }
    private func createAccount() async {
            do {
                _ = try await Auth.auth().createUser(withEmail: email, password: password)
                message = "Account Created "
            } catch {
                message = error.localizedDescription
            }
        }
    private func resetPassword() async {
            do {
                try await Auth.auth().sendPasswordReset(withEmail: email)
                message = "Reset Email Sent "
            } catch {
                message = error.localizedDescription
            }
        }
}
