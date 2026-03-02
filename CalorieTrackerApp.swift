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
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(authVM)
        }
    }
}
