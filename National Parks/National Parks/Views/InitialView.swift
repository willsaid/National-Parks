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
    
    var body: some View {
       ZStack {
            if auth.token == nil {
                SignupView(authType: .signup)
            } else {
                AllParksView(manager: ParksManager())
            }
        }
    }
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}
