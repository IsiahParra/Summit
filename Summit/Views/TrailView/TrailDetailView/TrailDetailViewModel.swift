//
//  trailDetailViewModel.swift
//  Summit
//
//  Created by Isiah Parra on 7/7/22.
//

import Foundation
import UIKit

class TrailDetailViewModel {
    
    var trail: Trail?
    init(trail: Trail? = nil) {
        self.trail = trail
    }
    func updateTrail(with name: String, location: String, entry: String, distance: Double, date: Date = Date(), completionTime: Double, rating: Int, imageURL:String?) {
        guard let trail = trail else { return }
        trail.trailName = name
        trail.entry = entry
        trail.location = location
        trail.distance = distance
        trail.date = date
        trail.completionTime = completionTime
        trail.imageURL = imageURL
    }
    // need to create a fetch function for the image after creating my firebaseService.
    func fetchImage() {
        
    }
    
   
}// end of class
