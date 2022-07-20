//
//  CurrentTrailTrackingViewController.swift
//  Summit
//
//  Created by Isiah Parra on 7/7/22.
//

import MapKit
import UIKit

class CurrentTrailTrackingViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var startStopButton: UIButton!
    
    private let locationManager: CLLocationManager = CLLocationManager()
    
    private var isTracking: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.startUpdatingLocation()
        setupMap()
    }
    
    @IBAction func startStopButtonTapped(_ sender: Any) {
        if isTracking {
            // End the hike
            // Show an alert asking the user if they are sure they want to end the hike.
            // If they choose no do nothing
            // If they choose yes, dismiss the screen and navigate to the hikes list, showing their new hike.
        } else {
            // Start the hike
            // Change the button from "Start" to "Stop",
            // Start the timer,
            // As the timer ticks, update the timerLabel
            // Start tracking their location.
            // As the user walks, update the distanceLabel
        }
    }
    
    private func setupMap() {
        guard let userCurrentLocation = locationManager.location?.coordinate
        else { return } // See if there is a better way to handle the else case
        
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: userCurrentLocation, span: span)
        mapView.region = region
    }

}
