//
//  SignupView.swift
//  loginapp_auth
//
//  Created by Rudra on 16/07/23.
//

import SwiftUI
import FirebaseAuth

struct SignupView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    
    @Binding var currentShowingView: String
    @AppStorage("uid") var userId: String = ""
    
    
    // password regex section
    
    private func isValidPassword(_ password: String) -> Bool {
        
        
        let passswordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$")
        
        return passswordRegex.evaluate(with: password)
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack{
                    Text("Create an Account!")
                        .font(.system(size: 35))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.all)
                    Spacer()
                }
                .padding(.top)
                Spacer()
                
                // For Email
                
                HStack {
                    Image(systemName: "mail")
                        .foregroundColor(.white)
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
                    .foregroundColor(.white))
                .padding()
                
                // For Password
                
                HStack {
                    Image(systemName: "key")
                        .foregroundColor(.white)
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
                    .foregroundColor(.white))
                .padding()
                
                Button(action: {
                    withAnimation {
                        self.currentShowingView = "login"
                    }
                }) {
                    Text("Already have an account?")
                        .foregroundColor(.gray)
                }
                
                Spacer()
                Spacer()
                
                
                Button(action: {
                    
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                        
                        if let error = error {
                            print(error)
                            return
                        }
                        
                        if let authResult = authResult {
                            print(authResult.user.uid)
                            userId = authResult.user.uid
                        }
                        
                    }
                    
//                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//                      // ...
//                    }
                    
                },
                       label: {
                    Text("Create New Account")
                        .foregroundColor(.black)
                        .font(.title3)
                        .bold()
                    
                        .frame(maxWidth: .infinity)
                        .padding()
                    
                        .background(
                        RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white))
                })
                .padding()
                
            }
        }
    }
}
