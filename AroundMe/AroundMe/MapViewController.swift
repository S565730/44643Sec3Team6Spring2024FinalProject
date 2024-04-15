//
//  MapViewController.swift
//  AroundMe
//
//  Created by Dhruvitha Challa on 4/12/24.
//

import UIKit
import MapKit
import AudioToolbox

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var addressLbl: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var selectedCategory: CategoryModel?
    
    private let locationManager = CLLocationManager()
    
    var myLocation = CLLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        
    }
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "mapToPlaces" {
            
            let vc = segue.destination as! PlacesViewController
            vc.selectedCategory = self.selectedCategory
            vc.lat = myLocation.coordinate.latitude
            vc.lng = myLocation.coordinate.longitude
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        myLocation = location
        
        // Zoom to user's current location
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        
        locationManager.stopUpdatingLocation()
        
        if let centerCoordinate = mapView?.centerCoordinate {
            let centerLocation = CLLocation(latitude: centerCoordinate.latitude, longitude: centerCoordinate.longitude)
            getAddressFromLocation(centerLocation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
         print("Error: \(error.localizedDescription)")
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
      
        let centerCoordinate = mapView.centerCoordinate
        print("Center Coordinate: \(centerCoordinate.latitude), \(centerCoordinate.longitude)")
        myLocation = CLLocation(latitude: centerCoordinate.latitude, longitude: centerCoordinate.longitude)
        getAddressFromLocation(CLLocation(latitude: centerCoordinate.latitude, longitude: centerCoordinate.longitude))
    }
    
    func getAddressFromLocation(_ location: CLLocation){
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Reverse geocoding failed with error: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first {
                // Construct the address string
                let address = "\(placemark.name ?? ""), \(placemark.locality ?? ""), \(placemark.administrativeArea ?? "") \(placemark.postalCode ?? ""), \(placemark.country ?? "")"
                
                print("Address: \(address)")
                
                self.addressLbl.text = address
            } else {
                print("No placemark found")
            }
        }
        
    }
    
    @IBAction func currentLocation(_ sender: Any) {
        AudioServicesPlaySystemSound(1104)
        if let userLocation = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: userLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        } else {
            print("Current location not available")
        }
        
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        AudioServicesPlaySystemSound(1104)
        self.performSegue(withIdentifier: "mapToPlaces", sender: self)
        
    }
}
