//
//  AllParksView.swift
//  National Parks
//
//  Created by Will Said on 1/19/20.
//  Copyright © 2020 Will Said. All rights reserved.
//

import SwiftUI

struct AllParksView: View {
    
    enum Filter: String {
        case Favorites, All
        
        func opposite() -> Filter {
            switch self {
            case .All: return .Favorites
            case.Favorites: return .All
            }
        }
    }
    
    @ObservedObject var manager: ParksManager
    @State private var filter: Filter = .All
    var filterToggleText: String {
        "Show \(filter.opposite().rawValue)"
    }
    
    var body: some View {
        NavigationView {
            List(0..<manager.allParks.count, id: \.self) { index in
                if self.filter == .All ||
                    self.manager.allParks[index].park.isFavorited {
                    ParkRowView(manager: self.manager,
                            index: index)
                    .onAppear {
                        self.manager.downloadImage(atIndex: index)
                    }
                }
            }
            .onAppear {
                self.manager.fetch()
            }
            .navigationBarTitle(Text(Auth.shared.username))
            .navigationBarItems(trailing:
                HStack {
                    Button(filterToggleText) {
                        self.filter = self.filter.opposite()
                    }
                    Spacer()
                    Button("Sign out") {
                        Auth.signout()
                    }
                }
            )
        }
    }
    
}

struct AllParksView_Previews: PreviewProvider {
    
    static var sampleManager: ParksManager {
        let manager = ParksManager()
        manager.allParks = [
            (park: ParkRowView_Previews.samplePark, imageView: Image("signup-background")),
            (park: ParkRowView_Previews.samplePark, imageView: Image("signup-background")),
            (park: ParkRowView_Previews.samplePark, imageView: Image("signup-background")),
            (park: ParkRowView_Previews.samplePark, imageView: Image("signup-background")),
            (park: ParkRowView_Previews.samplePark, imageView: Image("signup-background")),
        ]
        return manager
    }
    
    static var previews: some View {
        return AllParksView(manager: sampleManager)
    }
}
