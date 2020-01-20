//
//  InitialView.swift
//  National Parks
//
//  Created by Will Said on 1/19/20.
//  Copyright © 2020 Will Said. All rights reserved.
//

import SwiftUI

struct InitialView: View {
    @ObservedObject var auth = Auth.shared
    let manager = ParksManager()
    
    var body: some View {
       ZStack {
            if auth.token == nil {
                SignupView(authType: .signup)
            } else {
//                TabView {
                    AllParksView(manager: manager)
                        .tabItem {
                            Image(systemName: "list.dash")
                            Text("All Parks")
                        }.tag(0)
//                    ProfileView(manager: ParksManager())
//                        .tabItem {
//                            Image(systemName: "person")
//                            Text("My Parks")
//                        }.tag(1)
//                }
            }
        }
    }
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}
