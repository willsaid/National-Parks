//
//  LocationManager.swift
//  National Parks
//
//  Created by Will Said on 1/19/20.
//  Copyright © 2020 Will Said. All rights reserved.
//

import MapKit

class LocationManager: CLLocationManager, CLLocationManagerDelegate {
    
    /// assumes user doesnt move very far while using the app
    static var currentCoordinate: CLLocationCoordinate2D? {
        locationManager.location?.coordinate
    }
    
    static func authorizeAndInitialize() {
        //initializes current location manager
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()
    }
    
    static private var locationManager = CLLocationManager()
    
    static func miles(from coord1: CLLocationCoordinate2D, to coord2: CLLocationCoordinate2D) -> Double {
        let meters = CLLocation(latitude: coord1.latitude,
                                longitude: coord1.longitude)
                        .distance(from: CLLocation(latitude: coord2.latitude,
                                                   longitude: coord2.longitude))
        return meters / 1609.0 // meters -> miles
    }
    
}
