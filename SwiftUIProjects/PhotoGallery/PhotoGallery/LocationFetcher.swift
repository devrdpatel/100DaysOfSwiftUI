//
//  LocationFetcher.swift
//  PhotoGallery
//
//  Created by Dev Patel on 7/6/23.
//

import CoreLocation

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D? {
        didSet {
            print("New Location is: (\(lastKnownLocation?.latitude), \(lastKnownLocation?.longitude))")
        }
    }
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func stop() {
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
}
