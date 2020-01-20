//
//  ProfileView.swift
//  National Parks
//
//  Created by Will Said on 1/19/20.
//  Copyright © 2020 Will Said. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var manager: ParksManager

    var body: some View {
        NavigationView {
            List(0..<manager.allParks.count, id: \.self) { index in
                if self.manager.allParks[index].park.isFavorited ?? false {
                    ParkRowView(manager: self.manager,
                            index: index)
                    .onAppear {
                        self.manager.downloadImage(atIndex: index)
                    }
                }
            }
            
            .navigationBarTitle(Text(Auth.shared.username))
            .navigationBarItems(trailing:
                Button("Sign out") {
                    Auth.signout()
                }
            )
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(manager: AllParksView_Previews.sampleManager)
    }
}
