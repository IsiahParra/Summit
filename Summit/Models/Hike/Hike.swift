//
//  Hike.swift
//  Summit
//
//  Created by Isiah Parra on 7/5/22.
//

import Foundation
import UIKit

class Hike {
    var hikeName: String
    var location: String
    var rating: Int
    var date: Date
    var distance: Double
    var entry: String
    var trailID: String
    var userID: String
    var imageURL: String?
    var completionTime: Double
    var hikeImage: UIImage

enum Key {
    static let hikeName = "hikeName"
    static let location = "location"
    static let rating = "rating"
    static let date = "date"
    static let distance = "distance"
    static let entry = "entry"
    static let trailID = "trailID"
    static let userID = "userID"
    static let imageURL = "imageURL"
    static let completionTime = "completionTime"
    static let hikeImage = "hikeImage"

  }
    var trailData: [String:AnyHashable] {
        [Key.hikeName : self.hikeName,
         Key.location : self.location,
         Key.rating : self.rating,
         Key.date : self.date.timeIntervalSince1970,
         Key.distance : self.distance,
         Key.entry : self.entry,
         Key.trailID : self.trailID,
         Key.userID : self.userID,
         Key.imageURL : self.imageURL,
         Key.completionTime : self.completionTime,
         Key.hikeImage : self.hikeImage]
    }
    init(hikeName: String, location: String, rating: Int, date: Date = Date(), distance: Double, entry: String, trailID: String, userID: String, imageURL: String?, completionTime: Double, hikeImage: UIImage) {
        self.hikeName = hikeName
        self.location = location
        self.rating = rating
        self.date = date
        self.distance = distance
        self.entry = entry
        self.trailID = trailID
        self.userID = userID
        self.imageURL = imageURL
        self.completionTime = completionTime
        self.hikeImage = hikeImage
    }
    convenience init?(fromTrailDict dictionary: [String:Any]) {
        guard let hikeName = dictionary[Key.hikeName] as? String,
              let location = dictionary[Key.location] as? String,
              let rating = dictionary[Key.rating] as? Int,
              let date = dictionary[Key.date] as? Double,
              let distance = dictionary[Key.distance] as? Double,
              let entry = dictionary[Key.entry] as? String,
              let trailID = dictionary[Key.trailID] as? String,
              let userID = dictionary[Key.userID] as? String,
              let imageURL = dictionary[Key.imageURL] as? String,
              let completionTime = dictionary[Key.completionTime] as? Double,
              let hikeImage = dictionary[Key.hikeImage] as? UIImage
        else {return nil}
        self.init(hikeName: hikeName, location: location, rating: rating, date: Date(timeIntervalSince1970: date), distance: distance, entry: entry, trailID: trailID, userID: userID, imageURL: imageURL, completionTime: completionTime, hikeImage: hikeImage)
    }
}
