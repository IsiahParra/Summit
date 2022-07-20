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
    
    private let service: FirebaseSyncable
    private var trail: Trail?
    
    var hikes: [Hike] = []
    
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
    
    var numberOfHikes: Int {
        hikes.count
    }
    
    init(trail: Trail, service: FirebaseSyncable = FirebaseService()) {
        self.trail = trail
        self.service = service
    }
    
    func fetchHikes() {
        service.loadHikes { result in
            switch result {
            case .success(let hikes):
                self.hikes = hikes
            case .failure(let error):
                // maybe tell the view to show an error
                print(error.localizedDescription)
            }
        }
    }
    
    func hike(at index: Int) -> Hike {
        hikes[index]
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
