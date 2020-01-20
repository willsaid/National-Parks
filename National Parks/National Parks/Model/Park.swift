//
//  Park.swift
//  National Parks
//
//  Created by Will Said on 1/19/20.
//  Copyright © 2020 Will Said. All rights reserved.
//

import Foundation
import MapKit


struct Park: Codable {
    
    let _id: String
    let description: String
    let favCount: Int
    let image: String // image url
    let lat: Double
    let lon: Double
    let name: String
    let state: String
    
    var milesAway: Double {
        guard let currentCoord = LocationManager.currentCoordinate else { return Double(Int.max) }
        let parkCoord = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        return LocationManager.miles(from: currentCoord, to: parkCoord)
    }
    
    static func fetch(completion: @escaping ([Park]) -> Void) {
        Request.fetch(url: .allParks,
                      httpMethod: .GET,
                      body: nil,
                      authorization: Auth.shared.token)
        { (json, error) in
            if let json = json, let parksJson = json["parks"] as? [[String: Any]]
            {
                do {
                    let data = try JSONSerialization.data(withJSONObject: parksJson, options: .prettyPrinted)
                    let parks = try JSONDecoder().decode([Park].self, from: data)
                    completion(parks)
                } catch {
                    print(error)
                }
            } else {
                print("Error fetching parks", error ?? "")
            }
        }
    }
    
    
}

extension Park: Identifiable {
    var id: String {
        _id
    }
}
