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
        let auth = Auth(type: .signup, username: "", password: "")
        auth.token = getToken()
        return auth
    }()
    
    @Published var token: String? = nil
    
    static let tokenKey = "token"
    typealias completion = (_ success: Bool, _ error: String?) -> Void
    
    let type    : AuthType
    let username: String
    let password: String
    
    init(type: AuthType, username: String, password: String) {
        self.type = type
        self.username = username
        self.password = password
    }
    
    func authenticate(completion: @escaping completion) {
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
                    Self.saveToken(token)
                    completion(true, nil)
                } else {
                    completion(false, error)
                }
            }
        }
    }
    
    static func saveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: tokenKey)
        shared.token = token
    }
    
    static func getToken() -> String? {
        UserDefaults.standard.string(forKey: tokenKey)
    }
    
    static var currentlySignedIn: Bool {
        shared.token != nil
    }
}
