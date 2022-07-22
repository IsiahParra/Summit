//
//  CurrentTrailTrackingViewController.swift
//  Summit
//
//  Created by Isiah Parra on 7/7/22.
//

import MapKit
import UIKit
import CoreLocation
import SwiftUI
class CurrentTrailTrackingViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var resetButtonTapped: UIButton!
    @IBOutlet weak var finishedHikeButton: UIButton!
    
    let locationManager = CLLocationManager()
    
    var isTracking = false
    var startStopButtonToggle = false
    
    var timer: Timer = Timer()
    var count: Int = 0
    var timerCounting: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        startStopButton.setTitleColor(UIColor.green, for: .normal)
    }
    override func viewDidAppear(_ animated: Bool) {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setUpLocationManager()
            locationManagerDidChangeAuthorization(locationManager)
        } else {
            // show an alert letting the user know they have to turn this on.
        }
    }

    func showSettingsAlert() {
        let alertController = UIAlertController(title: "Please enable Location Services", message: "Location Services are needed to track your Hikes, please adjust in Settings", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Button: This dismisses the alert"), style: .cancel)
        let settingsAction = UIAlertAction(title: NSLocalizedString("Settings", comment: "Button: Takes the User to Settings Application"), style: .default) { action in
            
            guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingsURL) {
                UIApplication.shared.open(settingsURL)
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        self.present(alertController, animated: true)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locationManager.authorizationStatus {
        case .restricted, .denied:
            showSettingsAlert()
           // app's location features are being denied or restricted
           
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationManager.stopUpdatingLocation()
            
            setupMap(location: location)
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("There has been an error!", error.localizedDescription)
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Reset Timer?", message: "Are you sure you would like to reset the Timer?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            // do nothing
        }))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            self.count = 0
            self.timer.invalidate()
            self.timerLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            self.startStopButton.setTitle("START", for: .normal)
            self.startStopButton.setTitleColor(UIColor.green, for: .normal)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func startStopButtonTapped(_ sender: Any) {
        if (timerCounting) {
            timerCounting = false
            timer.invalidate()
            startStopButton.setTitle("START", for: .normal)
            startStopButton.setTitleColor(UIColor.green, for: .normal)
            // Show an alert asking the user if they are sure they want to end the hike.
            
            // End the hike
        }
        
        // If they choose no do nothing
        // If they choose yes, dismiss the screen and navigate to the hikes list, showing their new hike.
        else {
            timerCounting = true
            startStopButton.setTitle("STOP", for: .normal)
            startStopButton.setTitleColor(UIColor.red, for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
            //                startStopButton.setTitle("Stop", for: .normal)
            //            func finishedHiking() {
            //                let storyboard = UIViewController(nibName: "Hikes", bundle: nil)
            //                guard let TrailTracking = storyboard.presentingViewController else { return }
            //                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(viewController: TrailTracking)
            //            }
            //
        }
        
        
        // Start tracking their location.
        // As the user walks, update the distanceLabel
        // get location when the start the hike tracking and when they hit stop.
        // ignore or nil the end location when the user hits resume
        // building the stop patch and ascending timer.
        
        
        isTracking.toggle()
    }
    @objc func timerCounter() -> Void {
        count = count + 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        timerLabel.text = timeString
    }
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int,Int,Int) {
        return ((seconds / 3600),((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    
    private func setupMap(location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    @IBAction func finishedHikeButtonTapped(_ sender: Any) {
        let alertFinishedHike = UIAlertController(title: "Finished with your Hike?", message: "Are you sure you are done with the Hike?", preferredStyle: .alert)
        alertFinishedHike.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (_) in
            // do nothing
        }))
        alertFinishedHike.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            self.count = 0
            self.timer.invalidate()
            self.timerLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            self.startStopButton.setTitle("START", for: .normal)
            self.startStopButton.setTitleColor(UIColor.green, for: .normal)
//            let storyboard = UIStoryboard(name: "Hikes", bundle: nil)
//            guard let hikesController = storyboard.instantiateViewController(withIdentifier: "myHikesList") as? UIViewController else { return }
//            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(viewController: hikesController)
        }))
        self.present(alertFinishedHike, animated: true, completion: nil)
        
        
        
    }
    
    
}// end of class

extension CurrentTrailTrackingViewController: CLLocationManagerDelegate {
    
}


