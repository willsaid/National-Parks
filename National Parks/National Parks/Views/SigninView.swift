//
//  SigninView.swift
//  National Parks
//
//  Created by Michael Koohang on 1/21/20.
//  Copyright © 2020 Will Said. All rights reserved.
//

import SwiftUI


struct SigninView: View {
        
    @State private var showLogin = false
    @State private var username = String()
    @State private var password = String()
    @State private var error = false
    
    var body: some View {
        VStack {
            Spacer()
            self.titleView
            Spacer()
            VStack {
                if error {
                    self.errorText
                }
                self.usernameField
                self.passwordField
                self.signinButton
            }
            self.switchAuthButton
        }
            .background(Image("signin-background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all))
    }
    
    var errorText: some View {
        Text("Error: Please try again.")
            .modifier(AuthError())
    }
    
    var signinButton: some View {
        Button(action: {
            self.registerOrLogin()
        }) {
            Text("Sign In").bold()
                .frame(maxWidth: .infinity)
        }
        .modifier(AuthButton())
    }
    
    var usernameField: some View {
        TextField("Username", text: $username)
            .modifier(AuthTextField())
            .textContentType(.username)
            .autocapitalization(.none)
    }
    
    var passwordField: some View {
        SecureField("Password", text: $password)
            .modifier(AuthTextField())
            .textContentType(.password)
            .autocapitalization(.none)
    }
    
    var titleView: some View {
        Text("My Parks")
            .font(.largeTitle)
            .bold()
            .foregroundColor(Color.black)
    }
    
    var switchAuthButton: some View {
        Button(action: {
            self.showLogin = true
        }) {
            Text("Register a new account")
        }
        .sheet(isPresented: $showLogin) {
            SignupView()
        }
        .foregroundColor(Color.white)
        .padding()
    }
    
    func registerOrLogin() {
        Auth(type: .signin,
             username: self.username,
             password: self.password).authenticate()
        { (success, error) in
            if success {
                self.error = false
                self.showLogin = false
            } else {
                print(error ?? "Unknown Error")
                self.error = true
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
    }
}

