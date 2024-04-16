//
//  PlacesViewController.swift
//  AroundMe
//
//  Created by sai priya jetti on 4/12/24.
//

import UIKit
import SDWebImage
import AudioToolbox
class PlacesViewController: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var placesTV: UITableView!
    var selectedCategory: CategoryModel?
    var lat: Double = 0.0
    var lng: Double = 0.0
    
    var placesArray: [Place] = []
    var selectedPlace: Place?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placesTV.delegate = self
        placesTV.dataSource = self
        
        self.navigationItem.title = selectedCategory?.title
        
        self.placesTV.isHidden = true
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        
        let type = self.selectedCategory?.key ?? "restaurant"
        let key = "AIzaSyDTjCWVxgH8lszoivDh_6aD7jcPTk2854I"
        fetchNearbyPlaces(latitude: lat, longitude: lng, radius: 1000, type: type, apiKey: key) { result in
            switch result {
            case .success(let places):
                self.placesArray = places
                DispatchQueue.main.async {
                    self.placesTV.isHidden = false
                    self.spinner.isHidden = true
                    self.placesTV.reloadData()
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.placesTV.isHidden = false
                    self.spinner.isHidden = true
                    self.placesTV.reloadData()
                }
                print("Error fetching nearby places: \(error.localizedDescription)")
            }
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "placeDetailsSegue" {
            AudioServicesPlaySystemSound(1305)
            let vc = segue.destination as! PlaceDetailsViewController
            vc.location = selectedPlace?.geometry.location
            vc.navigationItem.title = selectedPlace?.name
        }
    }
    
    // Function to fetch nearby places
    func fetchNearbyPlaces(latitude: Double, longitude: Double, radius: Int, type: String, apiKey: String, completion: @escaping (Result<[Place], Error>) -> Void) {
        
        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latitude),\(longitude)&radius=\(radius)&type=\(type)&key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }

            do {
                let decoder = JSONDecoder()
                let nearbyPlacesResponse = try decoder.decode(NearbyPlacesResponse.self, from: data)
                completion(.success(nearbyPlacesResponse.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

var googleKey = "AIzaSyDTjCWVxgH8lszoivDh_6aD7jcPTk2854I"

extension PlacesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.placesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath) as! PlaceTableViewCell
        
        let place = self.placesArray[indexPath.row]
        cell.nameLbl.text = place.name
        cell.ratingLbl.text = "⭐️\(place.rating.map { String($0) } ?? "N/A") (\(place.user_ratings_total ?? 0))"
        cell.addressLbl.text = place.vicinity
        
        let icon = place.icon
        cell.imgView.sd_setImage(with: URL(string: icon))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedPlace = self.placesArray[indexPath.row]
        self.performSegue(withIdentifier: "placeDetailsSegue", sender: self)
    }
}


// Define a struct to represent a place
struct Place: Codable {
    let name: String
    let rating: Double?
    let user_ratings_total: Int?
    let vicinity: String
    let icon: String
    let geometry: Geometry
}

struct Geometry: Codable {
    let location: Location
}

struct Location: Codable {
    let lat: Double
    let lng: Double
}


// Define a struct to represent the response from the Google Places API
struct NearbyPlacesResponse: Codable {
    let results: [Place]
}

