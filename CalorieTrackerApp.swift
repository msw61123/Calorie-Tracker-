//
//  CalorieTrackerApp.swift
//  CalorieTracker
//
//  Created by Matthew Saeed on 2/25/26.
//

import SwiftUI
import FirebaseCore

@main
struct CalorieTrackerApp: App {
    @StateObject private var authVM = AuthViewModel()
    @AppStorage("didCompleteQuestionnaire") private var didCompleteQuestionnaire = false
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            if authVM.user == nil {
                LoginView()
                    .environmentObject(authVM)
            } else if !didCompleteQuestionnaire {
                QuestionnaireView()
                    .environmentObject(authVM)
            } else {
                HomeView()
                    .environmentObject(authVM)
            }
        }
    }
}
