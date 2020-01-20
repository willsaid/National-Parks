//
//  AllParksView.swift
//  National Parks
//
//  Created by Will Said on 1/19/20.
//  Copyright © 2020 Will Said. All rights reserved.
//

import SwiftUI

struct AllParksView: View {
    
    @ObservedObject var manager: ParksManager
    
    var body: some View {
        List(manager.allParks) { park in
            ParkRowView(park: park)
        }
        .onAppear {
            self.manager.fetch()
        }
    }
    
}

struct AllParksView_Previews: PreviewProvider {
    static var previews: some View {
        AllParksView(manager: ParksManager())
    }
}
