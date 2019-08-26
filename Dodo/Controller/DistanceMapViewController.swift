//
//  DistanceMap.swift
//  Dodo
//
//  Created by Galih Asmarandaru on 22/08/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import MapKit
import CoreLocation

class DistanceMapViewController: UIViewController {
    
    var theDistance: String?
    var locationManager = CLLocationManager()
    var userLocation: CLLocation?
    var donorLocation: CLLocation?
    
    func checkUserLocation() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
        }
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // Show alert instructing them how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show an alert letting them know what's up
            break
        case .authorizedAlways:
            break
        }
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            userLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        }
    }

    
    func getDistance(userLocation: CLLocation, donorLocation: CLLocation) {
        let distance = userLocation.distance(from: donorLocation)
        theDistance = "\(Double(round(1000*distance)/1000)) km"
    }
}

extension DistanceMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let _ = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}
