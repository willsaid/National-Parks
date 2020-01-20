//
//  ParksManager.swift
//  National Parks
//
//  Created by Will Said on 1/19/20.
//  Copyright © 2020 Will Said. All rights reserved.
//

import UIKit
import SwiftUI

class ParksManager: ObservableObject {
    
    @Published var allParks: [(park: Park, imageView: Image?)] = []
    
    // Indices of images ive already started fetching
    private var alreadyFetched = Set<Int>()
    
    /// Loaded from database upon launching app
    private var alreadyFavoritedParks = Set<Park>()
    
    func fetch() {
        LocationManager.authorizeAndInitialize()
        fetchMyFavorites {
            Park.fetch { (parks) in
                DispatchQueue.main.async {
                    self.allParks = parks
                        .sorted(by: { $0.milesAway < $1.milesAway })
                        .map { ($0, nil) }
                    for index in 0..<self.allParks.count {
                        self.allParks[index].park.isFavorited
                            = self.alreadyFavoritedParks.contains(self.allParks[index].park)
                    }
                }
            }
        }
    }
    
    private func fetchMyFavorites(completion: @escaping () -> Void) {
        Request.fetch(url: .user,
                      httpMethod: .GET,
                      body: nil,
                      authorization: Auth.shared.token)
        { (json, error) in
            if let json = json,
                let favorites = json["wishlist"] as? [[String: Any]],
                let parks = Park.parks(fromJSON: favorites)
            {
                self.alreadyFavoritedParks = Set<Park>(parks)
            } else {
                print("Failed to fetch my wishlist parks!", error ?? "")
            }
            completion()
        }
    }
    
    func downloadImage(atIndex i: Int) {
        if self.alreadyFetched.contains(i) { return }
        self.alreadyFetched.insert(i)
        for prevIndex in 0...i {
            downloadImage(atIndex: prevIndex) // to account for missed rows
        }
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
