//
//  TrailCreationViewModel.swift
//  Summit
//
//  Created by Isiah Parra on 7/7/22.
//

import Foundation

class TrailCreationViewModel {
var trail: Trail?

    init(trail: Trail? = nil){
    self.trail = trail
    }
    func saveTrail(with name: String, entry: String, location: String, imageURL: String?, rating: Int, date: Date = Date(), distance: Double) {
        if trail != nil {
            // need to update exsiting trail, and also create a new trail saving it to firebase
            // also being able to get an image from storage in firebase
        }
    }
}// end of class
