//
//  DetailView.swift
//  National Parks
//
//  Created by Will Said on 1/19/20.
//  Copyright © 2020 Will Said. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    var park: Park
    var image: Image?
    
    var body: some View {
        VStack {
            Text(park.name)
                .font(.largeTitle)
                .bold()
            (image ?? Image(systemName: "rectangle"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            Text(park.description)
        }
        .padding()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(park: ParkRowView_Previews.samplePark,
                   image: Image("signup-background"))
    }
}
