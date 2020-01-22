//
//  SignupView.swift
//  National Parks
//
//  Created by Will Said on 1/19/20.
//  Copyright © 2020 Will Said. All rights reserved.
//

import SwiftUI


struct SignupView: View {
    
    @Environment(\.presentationMode) var presentationMode
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
        Text("Error: Please try again.")
            .modifier(AuthError())
    }
    
    var signinButton: some View {
        Button(action: {
            self.registerOrLogin()
        }) {
            Text("Sign Up").bold()
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
            .foregroundColor(Color.white)
    }
    
    var switchAuthButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("Already have an account?")
        }
        .foregroundColor(Color.white)
        .padding()
    }
    
    func registerOrLogin() {
        Auth(type: .signup,
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
        SignupView()
    }
}
