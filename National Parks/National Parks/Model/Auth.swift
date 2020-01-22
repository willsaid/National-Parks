//
//  Auth.swift
//  National Parks
//
//  Created by Will Said on 1/19/20.
//  Copyright © 2020 Will Said. All rights reserved.
//

import Foundation
import Combine

enum AuthType {
    case signin, signup
}

class Auth: ObservableObject {
    
    static var shared: Auth = {
        let auth = Auth(type: .signup,
                        username: getUsername() ?? "",
                        password: "")
        auth.token = getToken()
        return auth
    }()
    
    static func signout() {
        shared.token = nil
        shared.username = ""
        UserDefaults.standard.removeObject(forKey: tokenKey)
        UserDefaults.standard.removeObject(forKey: nameKey)
        // this triggers the initial view to be set to the SignUpView
    }
    
    @Published var token: String? = nil
    
    static let tokenKey = "token"
    static let nameKey = "username"
        
    let type    : AuthType
    var username: String
    let password: String
    
    init(type: AuthType, username: String, password: String) {
        self.type = type
        self.username = username
        self.password = password
    }
    
    func authenticate(completion: @escaping (_ success: Bool, _ error: String?) -> Void) {
        Request.fetch(url: type == .signin ? .login : .registration,
                     httpMethod: .POST,
                     body: [
                        "username": self.username,
                        "password": self.password
                     ])
        { (json, error) in
            DispatchQueue.main.async {
                if let json = json, let token = json[Self.tokenKey] as? String {
                    print(json)
                    Self.saveToken(token, andUsername: self.username)
                    completion(true, nil)
                } else {
                    completion(false, error)
                }
            }
        }
    }
    
    static func saveToken(_ token: String, andUsername name: String) {
        UserDefaults.standard.set(token, forKey: tokenKey)
        UserDefaults.standard.set(name, forKey: nameKey)
        shared.token = token
        shared.username = name
    }
    
    static func getToken() -> String? {
        UserDefaults.standard.string(forKey: tokenKey)
    }
    
    static func getUsername() -> String? {
        UserDefaults.standard.string(forKey: nameKey)
    }
}
