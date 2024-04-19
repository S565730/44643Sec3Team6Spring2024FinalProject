//
//  PlaceDetailsViewController.swift
//  AroundMe
//
//  Created by sai priya jetti on 4/12/24.
//

import UIKit
import MapKit

class PlaceDetailsViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    var location: Location?
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.showsUserLocation = true
        // Do any additional setup after loading the view.
        self.showMarkerAndZoom(latitude: location?.lat ?? 0.0, longitude: location?.lng ?? 0.0)
    }
    
    @IBAction func Logout(_ sender: Any) {
        let alert = UIAlertController(title: "Logout", message: "Would you like to logout?", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                   alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { _ in
                     
                       
                       self.performSegue(withIdentifier: "BackToLogin", sender: self)
                   }))
                   present(alert, animated: true, completion: nil)
    }
    func showMarkerAndZoom(latitude: Double, longitude: Double) {
            // Create a CLLocationCoordinate2D instance for the marker
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

            // Create a custom annotation
            let annotation = CustomAnnotation(coordinate: coordinate)
            mapView.addAnnotation(annotation)

            // Set region to zoom to
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


// Custom annotation class
class CustomAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D

    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
