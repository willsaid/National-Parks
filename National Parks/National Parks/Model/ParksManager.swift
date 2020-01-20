//
//  ParksManager.swift
//  National Parks
//
//  Created by Will Said on 1/19/20.
//  Copyright © 2020 Will Said. All rights reserved.
//

import Foundation
import Combine

class ParksManager: ObservableObject {
    @Published var allParks: [Park] = []
    
    func fetch() {
        LocationManager.authorizeAndInitialize()
        Park.fetch { (parks) in
            DispatchQueue.main.async {
                print(parks[0])
                self.allParks = parks
                    .sorted(by: { $0.milesAway < $1.milesAway })
            }
        }
    }
}
