//
//  ParkRowView.swift
//  National Parks
//
//  Created by Will Said on 1/19/20.
//  Copyright © 2020 Will Said. All rights reserved.
//

import SwiftUI

struct ParkRowView: View {
    var park: Park
    
    var body: some View {
        Text(park.name)
    }
}

struct ParkRowView_Previews: PreviewProvider {
    static var previews: some View {
        ParkRowView(park: Park(_id: "5e23f4e7318123e9fe6712e6",
                               description: "Salt River Bay National Historical Park and Ecological Preserve uniquely documents the human and natural Caribbean world from the earliest indigenous settlements in the central Caribbean to their clash with seven different colonial European powers to the present day.",
                               favCount: 0,
                               image: "https://www.nps.gov/common/uploads/structured_data/D0B758DC-1DD8-B71B-0B463C640F211F0A.jpg",
                               lat: 17.77908602,
                               lon: -64.75519348,
                               name: "Salt River Bay",
                               state: "VI"))
    }
}
