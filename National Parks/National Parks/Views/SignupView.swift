//
//  SignupView.swift
//  National Parks
//
//  Created by Will Said on 1/19/20.
//  Copyright © 2020 Will Said. All rights reserved.
//

import SwiftUI


struct SignupView: View {
    var authType: AuthType
    
    @State private var showingAuthSwitch = false
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
            .background(Image("signup-background")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all))
    }
    
    var errorText: some View {
        Text("Try Again")
            .modifier(AuthTextField())
            .foregroundColor(Color.red)
    }
    
    var signinButton: some View {
        Button(action: {
            self.registerOrLogin()
        }) {
            (self.authType == .signup ?
                Text("Sign Up").bold() : Text("Sign In").bold())
                .frame(maxWidth: .infinity)
        }
        .modifier(AuthTextField())
    }
    
    var usernameField: some View {
        TextField("Username", text: $username)
            .modifier(AuthTextField())
            .textContentType(.username)
    }
    
    var passwordField: some View {
        SecureField("Password", text: $password)
            .modifier(AuthTextField())
            .textContentType(.password)
    }
    
    var titleView: some View {
        Text("My Parks")
            .font(.largeTitle)
            .bold()
            .foregroundColor(Color.black)
    }
    
    var switchAuthButton: some View {
        Button(action: {
            self.showingAuthSwitch.toggle()
        }) {
            self.authType == .signup ?
                Text("Already have an account?") :
                Text("Register a new account")
        }
        .sheet(isPresented: $showingAuthSwitch) {
            self.authType == .signup ?
                SignupView(authType: .signin) :
                SignupView(authType: .signup)
        }
        .foregroundColor(Color.white)
        .padding()
    }
    
    func registerOrLogin() {
        Auth(type: self.authType,
             username: self.username,
             password: self.password).authenticate()
        { (success, error) in
            if success {
                self.error = false
            } else {
                print(error ?? "Unknown Error")
                self.error = true
            }
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(authType: .signup)
    }
}
