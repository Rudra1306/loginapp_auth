//
//  LoginView.swift
//  loginapp_auth
//
//  Created by Rudra on 16/07/23.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    
    
    @Binding var currentShowingView: String
    @AppStorage("uid") var userId: String = ""
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    
    // password regex section
    
    private func isValidPassword(_ password: String) -> Bool {
        
        
        let passswordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Z].*[A-Z])(?=.*[!@#$&*])(?=.*[0-9].*[0-9])(?=.*[a-z].*[a-z].*[a-z]).{6}$")
        
        return passswordRegex.evaluate(with: password)
    }
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack{
                    Text("Welcome Back!")
                        .font(.system(size: 35))
                        .fontWeight(.bold)
                        .padding(.all)
                    Spacer()
                }
                .padding(.top)
                Spacer()
                
                // For Email
                
                HStack {
                    Image(systemName: "mail")
                    TextField("Email", text: $email)
                    
                    Spacer()
                    
                    if(email.count != 0) {
                        
                        Image(systemName: email.isValidEmail() ? "checkmark" : "xmark")
                            .fontWeight(.bold)
                            .foregroundColor(email.isValidEmail() ? .green : .red )
                    }
                }
                .padding()
                .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.black))
                .padding()
                
                // For Password
                
                HStack {
                    Image(systemName: "key")
                    SecureField("Password", text: $password)
                    
                    Spacer()
                    
                    if (password.count != 0) {
                        
                        Image(systemName: isValidPassword(password) ? "checkmark" : "xmark")
                            .fontWeight(.bold)
                            .foregroundColor(isValidPassword(password) ? .green : .red)
                    }
                }
                .padding()
                .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.black))
                .padding()
                
                Button(action: {
                    withAnimation {
                        self.currentShowingView = "signup"
                    }
                }) {
                    Text("Don't have an account?")
                        .foregroundColor(.black.opacity(0.7))
                }
                
                Spacer()
                Spacer()
                
                
                Button(action: {
                    Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                      
                        if let error = error {
                            print(error)
                            return
                        }
                        
                        if let authResult = authResult
                        {
                            print(authResult.user.uid)
                            withAnimation {
                                userId = authResult.user.uid
                            }
                        }
                    }
                },
                       label: {
                    Text("Sign In")
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                    
                        .frame(maxWidth: .infinity)
                        .padding()
                    
                        .background(
                        RoundedRectangle(cornerRadius: 10)
                        .fill(Color.black))
                })
                .padding()
                
            }
        }
    }
}
