//
//  SignupView.swift
//  National Parks
//
//  Created by Will Said on 1/19/20.
//  Copyright © 2020 Will Said. All rights reserved.
//

import SwiftUI

enum AuthType {
    case signin, signup
}

struct AuthTextField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.white)
            .padding()
            .background(Color.gray.opacity(0.8))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 2))
            .padding(.leading, 20)
            .padding(.trailing, 20)
    }
}

struct SignupView: View {
    
    var auth: AuthType
    
    @State private var showingAuthSwitch = false
    @State private var username = String()
    @State private var password = String()
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            Text("My Parks")
                .font(.largeTitle)
                .bold()
                .foregroundColor(Color.black)
            
            Spacer()
            
            VStack {
                TextField("Username", text: $username)
                    .modifier(AuthTextField())
                    
                TextField("Password", text: $password)
                    .modifier(AuthTextField())
                
                Button(action: {
                    // Register or Login
                }) {
                    (self.auth == .signup ?
                        Text("Sign Up").bold() : Text("Sign In").bold())
                        .frame(maxWidth: .infinity)
                }
                .modifier(AuthTextField())
            }
            
            Button(action: {
                self.showingAuthSwitch.toggle()
            }) {
                self.auth == .signup ?
                    Text("Already have an account?") :
                    Text("Register a new account")
            }.sheet(isPresented: $showingAuthSwitch) {
                self.auth == .signup ?
                    SignupView(auth: .signin) :
                    SignupView(auth: .signup)
            }
            .foregroundColor(Color.white)
            .padding()
        
        }
        
        .background(Image("signup-background")
        .resizable()
        .scaledToFill()
        .edgesIgnoringSafeArea(.all))
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(auth: .signup)
    }
}
