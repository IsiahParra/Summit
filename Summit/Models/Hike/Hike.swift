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
    var rating: Int?
    var timeStamp: Date
    var distance: String
    var trailID: String
    var userID: String
    var imageURL: URL?
    var completionTime: Double
    var hikeImage: UIImage?
    var uuid: String

enum Key {
    static let collectionType = "hikes"
    static let hikeName = "hikeName"
    static let location = "location"
    static let rating = "rating"
    static let timeStamp = "timeStamp"
    static let distance = "distance"
    static let trailID = "trailID"
    static let userID = "userID"
    static let imageURL = "imageURL"
    static let completionTime = "completionTime"
    static let hikeImage = "hikeImage"
    static let uuid = "uuid"

  }
    var hikeData: [String:AnyHashable] {
        [Key.hikeName : self.hikeName,
         Key.location : self.location,
         Key.rating : self.rating,
         Key.timeStamp : self.timeStamp.timeIntervalSince1970,
         Key.distance : self.distance,
         Key.trailID : self.trailID,
         Key.userID : self.userID,
         Key.imageURL : self.imageURL,
         Key.completionTime : self.completionTime,
         Key.hikeImage : self.hikeImage,
         Key.uuid : self.uuid]
    }
    init(hikeName: String, location: String, timeStamp: Date = Date(), distance: String,trailID: String, userID: String, imageURL: URL? = nil, completionTime: Double, hikeImage: UIImage?, uuid: String = UUID().uuidString) {
        self.hikeName = hikeName
        self.location = location
        self.timeStamp = timeStamp
        self.distance = distance
        self.trailID = trailID
        self.userID = userID
        self.imageURL = imageURL
        self.completionTime = completionTime
        self.hikeImage = hikeImage
        self.uuid = uuid
    }
    convenience init?(fromTrailDict dictionary: [String:Any]) {
        guard let hikeName = dictionary[Key.hikeName] as? String,
              let location = dictionary[Key.location] as? String,
              let distance = dictionary[Key.distance] as? String,
              let trailID = dictionary[Key.trailID] as? String,
              let userID = dictionary[Key.userID] as? String,
              let imageURL = dictionary[Key.imageURL] as? URL,
              let completionTime = dictionary[Key.completionTime] as? Double,
              let hikeImage = dictionary[Key.hikeImage] as? UIImage,
              let uuid = dictionary[Key.uuid] as? String
        else {return nil}
        self.init(hikeName: hikeName, location: location, distance: distance, trailID: trailID, userID: userID, imageURL: imageURL, completionTime: completionTime, hikeImage: hikeImage, uuid: uuid)
    }
}
