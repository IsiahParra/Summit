//
//  CurrentTrailTrackingViewModel.swift
//  Summit
//
//  Created by Isiah Parra on 7/7/22.
//

import Foundation
import CoreLocation
import UIKit

//class CurrentTrailTrackingViewModel {
//
//    var hike: Hike
//    private let service: FirebaseSyncable
//
//    init(hike: Hike? = nil, service: FirebaseSyncable = FirebaseService()){
//        self.hike = hike
//        self.service = service
//    }
//    func saveHike( With name: String, entry: String, location: String, image: UIImage?, distance: String, trailID: String, userID: String, completionTime: Double, completion: @escaping (Result<Void,Error>) -> Void) {
//        if hike != nil {
//            updateHike(with: name, entry: entry, location: location, image: image, distance: distance, trailID: trailID, userID: userID, completionTime: completionTime)
//        } else {
//            let hike = Hike(hikeName: name, location: location, distance: distance, trailID: trailID, userID: userID, completionTime: completionTime, hikeImage: image)
//            service.save(hike: hike, with: image)
//        }
//    }
//    
//    private func updateHike(with name: String, entry: String, location: String, image: UIImage?, distance: String, trailID: String, userID: String, completionTime: Double) {
//        guard let hike = hike else {
//            return
//        }
//    }


