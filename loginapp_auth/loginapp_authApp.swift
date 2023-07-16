//
//  loginapp_authApp.swift
//  loginapp_auth
//
//  Created by Rudra on 16/07/23.
//

import SwiftUI
import FirebaseCore

@main
struct loginapp_authApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
