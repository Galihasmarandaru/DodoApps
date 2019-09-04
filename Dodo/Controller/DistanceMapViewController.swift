//
//  DistanceMap.swift
//  Dodo
//
//  Created by Galih Asmarandaru on 22/08/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CloudKit

class DistanceMapViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var testMapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var goButton: UIButton!
 
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableViewSearch: UITableView!
    
    var database = CKContainer.default().publicCloudDatabase

    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    var theDistance: String?
    
    var previousLocation: CLLocation?
    var userLocation: CLLocation?
    var donorLocation: CLLocation?
    
    var matchingItems: [MKMapItem] = []

    let geoCoder = CLGeocoder()
    var directionsArray: [MKDirections] = []
    
    let getDisatance = CLLocationDistance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goButton.layer.cornerRadius = goButton.frame.size.height/2
        
        searchBar.delegate = self
        tableViewSearch.delegate = self
        tableViewSearch.dataSource = self
        
        checkLocationServices()
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            
        }
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            startTackingUserLocation()
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .authorizedAlways:
            break
        }
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            // mendapatkan current kordinat
            userLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
            
            //            donorLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
            
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            testMapView.setRegion(region, animated: true)
        }
    }
    
    func getDistance(donorLocation: CLLocation) -> String {
        let distance = userLocation!.distance(from: donorLocation)
        theDistance = "\(Double(round(1000*distance)/1000)) km"
        
        return theDistance!
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableViewSearch.isHidden = true
        searchBar.text = ""
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tableViewSearch.isHidden = false
        guard let mapView = testMapView,
            let searchBarText = searchBar.text else { return }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.tableViewSearch.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        tableViewSearch.isHidden = true
        searchBar.text = ""
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewSearch.isHidden = true
        searchBar.text = ""
        let positionAnnotation = MKPointAnnotation()
        
        let cordinatCliked  = matchingItems[indexPath.row].placemark.coordinate
        //Lokasilabel.text = matchingItems[indexPath.row].placemark.name
        self.searchBar.endEditing(true)
        positionAnnotation.title = matchingItems[indexPath.row].placemark.name
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: cordinatCliked , span: span)
        //        let pin = CustomPin(pinTitle: positionAnnotation.title!, pinSubTitle: "", location: positionAnnotation.coordinate, isVictim: false)
        //        mapView.addAnnotation(pin)
        //        print(pin.title)
        print(positionAnnotation.coordinate.latitude)
        print(positionAnnotation.coordinate.longitude)
        testMapView.setRegion(region, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UISearchTableViewCell
        let selectedItem = matchingItems[indexPath.row].placemark
        //let selectedItem = matchingItems[indexPath.row]
        
        cell.titleLabel?.text = selectedItem.name
        cell.subtitleLabel?.text = parseAddress(selectedItem: selectedItem)
        return cell
    }
    
    func parseAddress(selectedItem:MKPlacemark) -> String {
        
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil &&
            selectedItem.thoroughfare != nil) ? " " : ""
        
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) &&
            (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil &&
            selectedItem.administrativeArea != nil) ? " " : ""
        
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        
        return addressLine
    }
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    func startTackingUserLocation() {
        guard let test = testMapView else { return }
        test.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        
        // mendapatkan alamat dan kordinat alamat
        previousLocation = getCenterLocation(for: testMapView)
    }
    
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        let centerLocations = CLLocation(latitude: latitude, longitude: longitude)
        
        return centerLocations
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func getDirections() {
        guard let location = locationManager.location?.coordinate else {
            
            return
        }
        
        let request = createDirectionsRequest(from: location)
        let directions = MKDirections(request: request)
        resetMapView(withNew: directions)
        
        directions.calculate { [unowned self] (response, error) in
            guard let response = response else { return }
            
            for route in response.routes {
                self.testMapView.addOverlay(route.polyline)
                //                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
            //            DispatchQueue.main.async {
            //                self.distance()
            //            }
        }
    }
    
    func saveUserLocation() {
        // what kind of record that we going to save
        let data = CKRecord(recordType: "DogLover")
        data.setValue(data, forKey: "location")
        
        // ketika kita able to masukan value dan itu tidak nil
        database.save(data) { (record, _) in
            guard record != nil else { return }
            print("Save record with note \(String(describing: record?.object(forKey: "location")))")
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func createDirectionsRequest(from coordinate: CLLocationCoordinate2D) -> MKDirections.Request {
        let destinationCoordinate       = getCenterLocation(for: testMapView).coordinate
        let startingLocation            = MKPlacemark(coordinate: coordinate)
        let destination                 = MKPlacemark(coordinate: destinationCoordinate)
        
        let request                     = MKDirections.Request()
        request.source                  = MKMapItem(placemark: startingLocation)
        request.destination             = MKMapItem(placemark: destination)
        request.transportType           = .automobile
        request.requestsAlternateRoutes = true
        
        return request
    }
    
    
    func resetMapView(withNew directions: MKDirections) {
        testMapView.removeOverlays(testMapView.overlays)
        directionsArray.append(directions)
        let _ = directionsArray.map { $0.cancel() }
    }
    
    @IBAction func goButtonTapped(_ sender: UIButton) {
        // save userLocation to cloudKit
        saveUserLocation()
    }
    
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////

extension DistanceMapViewController: CLLocationManagerDelegate {    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////

extension DistanceMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        
        guard let previousLocation = self.previousLocation else { return }
        
        guard center.distance(from: previousLocation) > 50 else { return }
        self.previousLocation = center
        
        geoCoder.cancelGeocode()
        
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            
            if let _ = error {
                
                return
            }
            
            guard let placemark = placemarks?.first else {
                
                return
            }
            
            let streetNumber = placemark.subThoroughfare ?? ""
            let streetName = placemark.thoroughfare ?? ""
            
            DispatchQueue.main.async {
                self.addressLabel.text = "\(streetNumber) \(streetName)"
                self.searchBar.text = "\(streetNumber) \(streetName)"
            }
        }
    }
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = .blue
        
        return renderer
    }
}
