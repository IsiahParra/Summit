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
    
    var trail: Trail?
    private weak var delegate: TrailDetailViewModelDelegate?
    private var service: FirebaseSyncable
    
    init(trail: Trail? = nil, service: FirebaseSyncable = FirebaseService(), delegate: TrailDetailViewModelDelegate) {
        self.trail = trail
        self.service = service
        self.delegate = delegate
    }
    func updateTrail(with name: String, location: String, entry: String, distance: String, rating: Int, imageURL:URL?) {
        guard let trail = trail else { return }
        trail.trailName = name
        trail.entry = entry
        trail.location = location
        trail.distance = distance
        trail.imageURL = imageURL
    }
    
    func loadTrails() {
        service.loadTrails { result in
            switch result {
            case .success(let trails):
//                self.trail = trails
                self.delegate?.trailsLoadedSuccessfully()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // need to create a fetch function for the image after creating my firebaseService.
    func getImage(comepletion: @escaping (UIImage?) -> Void) {
        guard let trail = trail else {
            return
        }
        service.fetchImageTrail(from: trail) { result in
            switch result {
            case .success(let image):
                comepletion(image)
            case .failure(let error):
                print(error)
                comepletion(nil)
            }
        }
        
    }
    
   
}// end of class
