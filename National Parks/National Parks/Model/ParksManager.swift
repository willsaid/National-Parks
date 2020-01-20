//
//  ParksManager.swift
//  National Parks
//
//  Created by Will Said on 1/19/20.
//  Copyright © 2020 Will Said. All rights reserved.
//

import Foundation
import Combine
import UIKit
import SwiftUI

class ParksManager: ObservableObject {
    @Published var allParks: [(park: Park, imageView: Image?)] = []
    
    // Indices of images ive already started fetching
    var alreadyFetched = Set<Int>()

    func fetch() {
        LocationManager.authorizeAndInitialize()
        Park.fetch { (parks) in
            DispatchQueue.main.async {
                print(parks[0])
                self.allParks = parks
                    .sorted(by: { $0.milesAway < $1.milesAway })
                    .map { ($0, nil)}
            }
        }
    }
    
    func downloadImage(atIndex i: Int) {
        if self.alreadyFetched.contains(i) { return }
        self.alreadyFetched.insert(i)
        let park = allParks[i].park
        
        URLSession.shared.dataTask(with: URL(string: park.image)!) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching image \(String(describing: error))")
                return
            }
            DispatchQueue.main.async() {
                self.allParks[i].imageView = Image(uiImage: UIImage(data: data) ?? UIImage())
            }
        }.resume()
    }
}
