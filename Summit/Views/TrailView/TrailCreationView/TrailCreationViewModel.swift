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
    
    func saveTrail(with name: String, entry: String, location: String, image: UIImage?, distance: String, completion: @escaping (Result<Void, Error>) -> Void) {
        // need to update exsiting trail, and also create a new trail saving it to firebase
        if trail != nil {
            updateTrail(with: name, entry: entry, location: location, image: image, distance: distance)
        } else {
            let trail = Trail(trailName: name, location: location, distance: distance, entry: entry, image: image)
            service.save(trail: trail, with: image, completion: completion)
        }
        // also being able to get an image from storage in firebase
    }
    
    private func updateTrail(with name: String, entry: String, location: String, image: UIImage?, distance: String) {
        guard let trail = trail else {
            return
        }
    }
    func getImage( from trail: Trail?, completion: @escaping (UIImage? ) -> Void) {
        guard let trail = trail else {
            return
        }
        service.fetchImageTrail(from: trail) { result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
    
}// end of class
