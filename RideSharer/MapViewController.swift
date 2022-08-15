//
//  MapViewController.swift
//  RideSharer
//
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
    }
    
    //check if location services are enabled
    func checkLocationServices() {
        //if enabled, check for authorization status
        if CLLocationManager.locationServicesEnabled() {
            checkAuthorizationStatus()
        //if not enabled, display an alert saying so
        } else {
            createAlert(title: "Unable to Display Location", message: "enable location services")
        }
    }
    
    //check for authorization status
    func checkAuthorizationStatus() {
        switch locationManager.authorizationStatus {
            //if allowed to access location, display the current location
            case .authorizedWhenInUse, .authorizedAlways:
                mapView.showsUserLocation = true
            //if not allowed, display an alert saying so
            case .denied, .restricted:
                createAlert(title: "Unable to Display Location", message: "allow app to access your location to enable map feature")
            //if unknown or not set, ask user to select authorization
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                mapView.showsUserLocation = true
        @unknown default:
            createAlert(title: "Unable to Display Location", message: "allow app to access your location to enable map feature")
        }
    }
    
    //create an alert with the specified title and message
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            // add ok button
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
    }
    
}
