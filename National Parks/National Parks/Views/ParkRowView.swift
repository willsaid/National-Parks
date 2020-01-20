//
//  ParkRowView.swift
//  National Parks
//
//  Created by Will Said on 1/19/20.
//  Copyright © 2020 Will Said. All rights reserved.
//

import SwiftUI

struct ParkRowView: View {
    
    @ObservedObject
    var manager: ParksManager
    var index: Int
    
    @State private var showingDetail = false
    
    var park: Park {
        manager.allParks[index].park
    }
    
    var image: Image? {
        manager.allParks[index].imageView
    }
    
    var body: some View {
        Button(action: {
            self.showingDetail.toggle()
        }) {
            self.rowView
        }
        .sheet(isPresented: $showingDetail) {
            DetailView(park: self.park, image: self.image)
        }
    }
    
    var rowView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(park.name + ", " + park.state)
                HStack {
                    favoriteButton()
                    Text(String(park.favCount))
                }
            }
            Spacer()
            imageView
        }
        .frame(maxWidth: .infinity, maxHeight: 100)
    }
    
    var imageView: some View {
        Group {
            if image != nil {
                image!
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 100, maxHeight: 100)
            } else {
                EmptyView()
                    .frame(width: 100, height: 100)
            }
        }
    }
    
    func favoriteButton() -> some View {
        Button(action: {
            if (self.park.isFavorited ?? false) {
                self.manager.allParks[self.index].park.unfavorite()
            } else {
                self.manager.allParks[self.index].park.favorite()
            }
        }) {
            (self.park.isFavorited ?? false) ?
                Image(systemName: "star.fill") :
                Image(systemName: "star")
        }
        .frame(width: 50, height: 50)
        .foregroundColor(Color.yellow)
    }
}

struct ParkRowView_Previews: PreviewProvider {
    static let samplePark = Park(_id: "5e23f4e7318123e9fe6712e6",
                                        description: "Salt River Bay National Historical Park and Ecological Preserve uniquely documents the human and natural Caribbean world from the earliest indigenous settlements in the central Caribbean to their clash with seven different colonial European powers to the present day.",
                                        favCount: 0,
                                        image: "https://www.nps.gov/common/uploads/structured_data/D0B758DC-1DD8-B71B-0B463C640F211F0A.jpg",
                                        lat: 17.77908602,
                                        lon: -64.75519348,
                                        name: "Salt River Bay",
                                        state: "VI")
    static var previews: some View {
        let manager = ParksManager()
        manager.allParks = [(park: samplePark, imageView: Image("signup-background"))]
        return List {
            ParkRowView(manager: manager, index: 0)
        }
    }
}
