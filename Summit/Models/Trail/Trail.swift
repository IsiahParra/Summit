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
    var uuid: String
    var imageURL: URL?
    var completionTime: Double
    // not saved in firestore, it has to be fetched seperatly
    var image: UIImage?

enum Key {
    static let trailName = "trailName"
    static let location = "location"
    static let rating = "rating"
    static let date = "date"
    static let distance = "distance"
    static let entry = "entry"
    static let uuid = "uuid"
    static let image = "image"
    static let imageURL = "imageURL"
    static let completionTime = "completionTime"
    static let collectionType = "trails"

  }
   // Dictionary representation
    var trailData: [String:AnyHashable] {
        [Key.trailName : self.trailName,
         Key.location : self.location,
         Key.rating : self.rating,
         Key.date : self.date.timeIntervalSince1970,
         Key.distance : self.distance,
         Key.entry : self.entry,
         Key.uuid : self.uuid,
         Key.imageURL : self.imageURL,
         Key.completionTime : self.completionTime]
    }
    init(trailName: String, location: String, rating: Int, date: Date = Date(), distance: Double, entry: String, uuid: String, image: UIImage?, imageURL: URL?, completionTime: Double) {
        self.trailName = trailName
        self.location = location
        self.rating = rating
        self.date = date
        self.distance = distance
        self.entry = entry
        self.uuid = uuid
        self.image = image
        self.imageURL = imageURL
        self.completionTime = completionTime
    }
    convenience init?(fromTrailDict dictionary: [String:Any]) {
        guard let trailName = dictionary[Key.trailName] as? String,
              let location = dictionary[Key.location] as? String,
              let rating = dictionary[Key.rating] as? Int,
              let date = dictionary[Key.date] as? Double,
              let distance = dictionary[Key.distance] as? Double,
              let entry = dictionary[Key.entry] as? String,
              let uuid = dictionary[Key.uuid] as? String,
              let imageURL = dictionary[Key.imageURL] as? URL,
              let completionTime = dictionary[Key.completionTime] as? Double
        else {return nil}
        self.init(trailName: trailName, location: location, rating: rating, date: Date(timeIntervalSince1970: date), distance: distance, entry: entry, uuid: uuid, image: nil, imageURL: imageURL, completionTime: completionTime) //image nil for now.
    }
}
