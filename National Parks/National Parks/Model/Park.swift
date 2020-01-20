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
    
    /*
     Instance variables must perfectly match
     what's returned in the JSON
     */
    let _id         : String
    let description : String
    var favCount    : Int
    let image       : String // image url
    let lat         : Double
    let lon         : Double
    let name        : String
    let state       : String
    
    /*
     Additional vars added after initialization
     */
    var isFavorited: Bool? = nil

    
    var milesAway: Double {
        guard let currentCoord = LocationManager.currentCoordinate
            else { return Double(Int.max) }
        let parkCoord = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        return LocationManager.miles(from: currentCoord, to: parkCoord)
    }
    
    static func fetch(completion: @escaping ([Park]) -> Void) {
        Request.fetch(url: .allParks,
                      httpMethod: .GET,
                      body: nil,
                      authorization: Auth.shared.token)
        { (json, error) in
            if let json = json,
                let parksJson = json["parks"] as? [[String: Any]],
                let parks = parks(fromJSON: parksJson)
            {
                completion(parks)
            } else {
                print("Error fetching parks", error ?? "")
            }
        }
    }
    
    static func parks(fromJSON parksJson: [[String: Any]]) -> [Park]? {
        do {
            let data = try JSONSerialization.data(withJSONObject: parksJson, options: .prettyPrinted)
            let parks = try JSONDecoder().decode([Park].self, from: data)
            return parks
        } catch {
            print(error)
            return nil
        }
    }
    
    mutating func favorite() {
        self.favCount += 1
        self.isFavorited = true
        Request.fetch(url: .favorite,
                      httpMethod: .POST,
                      body: ["park_id": self.id],
                      authorization: Auth.shared.token) { (json, error) in
            if let error = error {
                print("error favoriting park", error)
            }
        }
    }
    
    mutating func unfavorite() {
        self.favCount -= 1
        self.isFavorited = false
        Request.fetch(url: .unfavorite,
                      httpMethod: .POST,
                      body: ["park_id": self.id],
                      authorization: Auth.shared.token) { (json, error) in
            if let error = error {
                print("error un-favoriting park", error)
            }
        }
    }
}

extension Park: Identifiable, Hashable {
    var id: String {
        _id
    }
}
