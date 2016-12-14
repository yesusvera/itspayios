//
//  Location.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/14/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit
import CoreLocation

class Location: UIViewController, CLLocationManagerDelegate {
    static let sharedInstance = Location()
    
    let locationManager = CLLocationManager()
    
    var currentLocation = CLLocation()
    
    func startUpdating() {
        if (CLLocationManager.locationServicesEnabled()) {
            Location.sharedInstance.locationManager.delegate = self
            Location.sharedInstance.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            Location.sharedInstance.locationManager.requestAlwaysAuthorization()
            Location.sharedInstance.locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        Location.sharedInstance.currentLocation = locations.last! as CLLocation
    }
}
