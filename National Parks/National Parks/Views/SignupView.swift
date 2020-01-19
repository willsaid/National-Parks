//
//  SignupView.swift
//  National Parks
//
//  Created by Will Said on 1/19/20.
//  Copyright © 2020 Will Said. All rights reserved.
//

import SwiftUI


struct SignupView: View {
    
    var auth: AuthType
    
    enum AuthType {
        case signin, signup
    }
    
    @State private var showingAuthSwitch = false
    @State private var username = String()
    @State private var password = String()
    
    var body: some View {
        VStack {
            Spacer()
            self.titleView
            Spacer()
            VStack {
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
    
    var signinButton: some View {
        Button(action: {
            // Register or Login
        }) {
            (self.auth == .signup ?
                Text("Sign Up").bold() : Text("Sign In").bold())
                .frame(maxWidth: .infinity)
        }
        .modifier(AuthTextField())
    }
    
    var usernameField: some View {
        TextField("Username", text: $username)
            .modifier(AuthTextField())
    }
    
    var passwordField: some View {
        TextField("Password", text: $password)
            .modifier(AuthTextField())
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
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(auth: .signup)
    }
}
