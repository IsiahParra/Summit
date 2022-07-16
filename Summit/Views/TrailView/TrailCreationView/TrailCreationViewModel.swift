//
//  TrailCreationViewModel.swift
//  Summit
//
//  Created by Isiah Parra on 7/7/22.
//

import Foundation
import UIKit

class TrailCreationViewModel {
    
    var trail: Trail?
    private let service: FirebaseSyncable
    init(trail: Trail? = nil, service: FirebaseSyncable = FirebaseService()) {
        self.trail = trail
        self.service = service
    }
    
    func saveTrail(with name: String, entry: String, location: String, image: UIImage, rating: Int, distance: Double) {
        // need to update exsiting trail, and also create a new trail saving it to firebase
        if trail != nil {
            updateTrail(with: name, entry: entry, location: location, image: image, rating: rating, distance: distance)
        } else {
            let trail = Trail(trailName: name, location: location, distance: distance, entry: entry, image: image)
            service.save(trail: trail, with: image)
            // TODO: Ask karl or someone with a little bit more experience why it makes you call all the other properties from the model for the else statment. do I need to initalize some properties?
            
        }
        // also being able to get an image from storage in firebase
    }
    private func updateTrail(with name: String, entry: String, location: String, image: UIImage, rating: Int, distance: Double) {
        guard let trail = trail else {
            return
        }
        trail.trailName = name
        trail.entry = entry
        trail.location = location
        trail.image = image
        trail.rating = rating
        trail.distance = distance
        service.save(trail: trail, with: image)
    }
    
}// end of class
