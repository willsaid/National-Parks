//
//  AuthButton.swift
//  National Parks
//
//  Created by Michael Koohang on 1/21/20.
//  Copyright © 2020 Will Said. All rights reserved.
//

import SwiftUI

struct AuthButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
            .padding(.leading, 20)
            .padding(.trailing, 20)
    }
}
