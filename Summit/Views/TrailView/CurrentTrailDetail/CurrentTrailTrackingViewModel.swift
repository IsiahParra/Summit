//
//  CurrentTrailTrackingViewModel.swift
//  Summit
//
//  Created by Isiah Parra on 7/7/22.
//

import Foundation
import CoreLocation

class CurrentTrailTrackingViewModel {
    
    var trail: Trail?
    var locationServices = CLLocationManager()
    
    init(trail: Trail? = nil, locationServices: CLLocationManager){
        self.trail = trail
        self.locationServices = locationServices
    }
    func trackTrail(with distance: Double, location: String, completionTime: Double) {
        guard let trail = trail else { return }
        trail.distance = distance
        trail.location = location
    }
}

