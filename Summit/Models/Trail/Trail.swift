//
//  Trail.swift
//  Summit
//
//  Created by Isiah Parra on 7/2/22.
//

import Foundation
import UIKit

class Trail {
    //properties
    var trailName: String
    var location: String
    var rating: Int
    var date: Date
    var distance: Double
    var entry: String
    var id: String
    var imageURL: String?
    // not saved in firestore, it has to be fetched seperatly
    var image: UIImage?

enum Key {
    static let trailName = "trailName"
    static let location = "location"
    static let rating = "rating"
    static let date = "date"
    static let distance = "distance"
    static let entry = "entry"
    static let id = "id"
    static let image = "image"
    static let imageURL = "imageURL"

  }
   // Dictionary representation
    var trailData: [String:AnyHashable] {
        [Key.trailName : self.trailName,
         Key.location : self.location,
         Key.rating : self.rating,
         Key.date : self.date.timeIntervalSince1970,
         Key.distance : self.distance,
         Key.entry : self.entry,
         Key.id : self.id,
         Key.imageURL : self.imageURL]
    }
    init(trailName: String, location: String, rating: Int, date: Date = Date(), distance: Double, entry: String, id: String, image: UIImage?, imageURL: String?) {
        self.trailName = trailName
        self.location = location
        self.rating = rating
        self.date = date
        self.distance = distance
        self.entry = entry
        self.id = id
        self.image = image
        self.imageURL = imageURL
    }
    convenience init?(fromTrailDict dictionary: [String:Any]) {
        guard let trailName = dictionary[Key.trailName] as? String,
              let location = dictionary[Key.location] as? String,
              let rating = dictionary[Key.rating] as? Int,
              let date = dictionary[Key.date] as? Double,
              let distance = dictionary[Key.distance] as? Double,
              let entry = dictionary[Key.entry] as? String,
              let id = dictionary[Key.id] as? String,
              let imageURL = dictionary[Key.imageURL] as? String
        else {return nil}
        self.init(trailName: trailName, location: location, rating: rating, date: Date(timeIntervalSince1970: date), distance: distance, entry: entry, id: id, image: nil, imageURL: imageURL) //image nil for now.
    }
}
