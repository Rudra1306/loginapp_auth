//
//  ContentView.swift
//  loginapp_auth
//
//  Created by Rudra on 16/07/23.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @AppStorage("uid") var userId: String = ""
    
    var body: some View {
        
        if userId == "" {
            AuthView()
        } else  {
            Text("Logged In! \nYour user id is \((userId))")
                .font(.largeTitle)
                .bold()
            
            Button(action: {
                let firebaseAuth = Auth.auth()
                do {
                  try firebaseAuth.signOut()
                    withAnimation {
                        userId = ""
                    }
                } catch let signOutError as NSError {
                  print("Error signing out: %@", signOutError)
                }
            }) {
                Text("Sign Out")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
