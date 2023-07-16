//
//  AuthView.swift
//  loginapp_auth
//
//  Created by Rudra on 16/07/23.
//

import SwiftUI

struct AuthView: View {
    
    @State private var currentViewShowing: String = "login"
    
    var body: some View {
        
        if (currentViewShowing == "login") {
            LoginView(currentShowingView: $currentViewShowing)
                .preferredColorScheme(.light)
        } else {
            SignupView(currentShowingView: $currentViewShowing)
                .preferredColorScheme(.dark)
                .transition(.move(edge: .trailing))
        }
        
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
