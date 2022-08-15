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
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            checkAuthorizationStatus()
        } else {
            createAlert(title: "Unable to Display Location", message: "enable location services")
        }
    }
    
    func checkAuthorizationStatus() {
        switch locationManager.authorizationStatus {
            case .authorizedWhenInUse, .authorizedAlways:
                mapView.showsUserLocation = true
            case .denied, .restricted:
                createAlert(title: "Unable to Display Location", message: "allow app to access your location to enable map feature")
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                mapView.showsUserLocation = true
        @unknown default:
            createAlert(title: "Unable to Display Location", message: "allow app to access your location to enable map feature")
        }
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            // add ok button
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
    }
    
}
