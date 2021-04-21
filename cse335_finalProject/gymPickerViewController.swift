//
//  gymPickerViewController.swift
//  cse335_finalProject
//
//  Created by Chase Brown on 4/7/21.
//

import UIKit
import MapKit
import CoreLocation

class gymPickerViewController: UIViewController, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var gym_table: UITableView!
    
    var workoutList: [String] = []
    
    var closestGyms = [MKMapItem](repeating: MKMapItem(), count: 25)
    
    var gym_names = [String](repeating: String(), count: 25)
    var gym_placemarks = [String]()
    var sessionInfo = session()
    var workout = String()
    
    var latitude = String()
    var longitude = String()
    
    @IBOutlet weak var startButton: UIButton!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        
        self.map.mapType = MKMapType.standard
        checkLocationServices()
        map.showsUserLocation = true
        centerViewOnUserLocation()
        query()
        
        gym_table.delegate = self
        gym_table.dataSource = self
        
        gym_table.reloadData()
        
        
        //dispatch_async(dispatch_get_main_queue(), ^{
        //    [self. tableView reloadData];
        //})
        
        let closest_pin = MKPointAnnotation()
        closest_pin.title = closestGyms[0].name
        closest_pin.coordinate = closestGyms[0].placemark.coordinate
        map.addAnnotation(closest_pin)
        
        mapView(map, viewFor: closest_pin)
        
    }
    
    
    func getClosest(queryList: [MKMapItem]) {
        
        var gymItem: MKMapItem
        
        for i in 0...24 {
            gym_names[i] = queryList[i].name!
            closestGyms[i] = queryList[i]
        }
        
        print("Printing closestGyms")
        print(self.closestGyms)
    }
    
    
    func query() {
        
        let request = MKLocalSearch.Request()
        let gym_search = "Gym"
        request.naturalLanguageQuery = gym_search
        request.region = map.region
        let search = MKLocalSearch(request: request)
    
        search.start
        {
            response, _ in guard let response = response else {
                return
            }
            print(response.mapItems)
            var matchingItems: [MKMapItem] = []
            matchingItems = response.mapItems
            
            for i in 1...matchingItems.count - 1
            {
                let place = matchingItems[i].placemark
                let gym_lat: CLLocationDegrees = (place.location? .coordinate.latitude)!
                let gym_lon: CLLocationDegrees = (place.location? .coordinate.longitude)!
                let gym_name = place.name!
                
                print(gym_lat)
                print(gym_lon)
                print(gym_name)
                
            }
            
            print(matchingItems.count)
            self.getClosest(queryList: matchingItems)
            //closest_gym_name = closest_gym.title
        
        }
        
        
        //let closest_gym_lat: CLLocationDegrees = (closest_gym.location? .coordinate.latitude)!
        //let closest_gym_lon: CLLocationDegrees = (closest_gym.location? .coordinate.longitude)!
        //
        //let coordinates = CLLocationCoordinate2D(latitude: closest_gym_lat, longitude: closest_gym_lon)
        //let span: MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        //
        //let region: MKCoordinateRegion = MKCoordinateRegion.init(center: coordinates, span: span)
        //
        //self.map.setRegion(region, animated: true)
        //
        //let annotation = MKPointAnnotation()
        //annotation.coordinate = coordinates
        //annotation.title = "Closest Gym"
        //annotation.subtitle = closest_gym_name
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = gym_table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = closestGyms[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            
        }
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location? .coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 10000, longitudinalMeters: 10000)
            map.setRegion(region, animated: true)
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            map.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // Show alert to show how to turn on
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            // Show alert of restriction
            break
        case .authorizedAlways:
            break
        @unknown default:
            map.showsUserLocation = true
            centerViewOnUserLocation()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndex: IndexPath = self.gym_table.indexPath(for: sender as! UITableViewCell)!
        let vc = segue.destination as? startWorkoutViewController
        
        vc?.workoutList = self.workoutList
        vc?.closestGym = self.closestGyms[selectedIndex.row]
        vc?.sessionInfo = self.sessionInfo
        vc?.workout = self.workout
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension gymPickerViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //
    }
}
