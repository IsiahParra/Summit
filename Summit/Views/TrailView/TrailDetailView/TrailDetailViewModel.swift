//
//  trailDetailViewModel.swift
//  Summit
//
//  Created by Isiah Parra on 7/7/22.
//

import Foundation
import UIKit
protocol TrailDetailViewModelDelegate: AnyObject {
    func trailsLoadedSuccessfully()
}

class TrailDetailViewModel {
    
   private var trail: Trail?
    var trailName: String {
        trail?.trailName ?? ""
    }
    var location: String {
        trail?.location ?? ""
    }
    var description: String {
        trail?.entry ?? ""
    }
    var distance: String {
        trail?.distance ?? ""
    }
    
    init(trail: Trail) {
        self.trail = trail
    }
    
    func updateTrail(with trail: String) {
//        trail.trailName = name
//        trail.entry = entry
//        trail.location = location
//        trail.distance = distance
//        trail.imageURL = imageURL
    }
    
    func displayTrailDetails(trailName: String, location: String, entry: String, distance: String, image: UIImage?) {
        
    }
    
   
}// end of class
