//
//  Trail.swift
//  Summit
//
//  Created by Isiah Parra on 7/2/22.
//

import Foundation
import UIKit

struct Trail {
    //properties
    var timeStamp: Date
    var trailName: String
    var location: String
    var rating: Int?
    var distance: String
    var entry: String
    var uuid: String
    var imageURL: URL?
    // not saved in firestore, it has to be fetched seperatly
    var image: UIImage?

enum Key {
    static let timeStamp = "timeStamp"
    static let trailName = "trailName"
    static let location = "location"
    static let distance = "distance"
    static let entry = "entry"
    static let uuid = "uuid"
    static let image = "image"
    static let imageURL = "imageURL"
    static let collectionType = "trails"

  }
   // Dictionary representation
    var trailData: [String:AnyHashable] {
        [Key.trailName : self.trailName,
         Key.location : self.location,
         Key.distance : self.distance,
         Key.entry : self.entry,
         Key.uuid : self.uuid,
         Key.imageURL : self.imageURL,
         Key.timeStamp : self.timeStamp]
    }
    init(trailName: String, location: String, rating: Int? = nil, distance: String, entry: String, uuid: String = UUID().uuidString, image: UIImage?, imageURL: URL? = nil, timeStamp: Date = Date()) {
        self.trailName = trailName
        self.location = location
        self.rating = rating
        self.distance = distance
        self.entry = entry
        self.uuid = uuid
        self.image = image
        self.imageURL = imageURL
        self.timeStamp = timeStamp
    }
    init?(fromTrailDict dictionary: [String:Any]) {
        guard let trailName = dictionary[Key.trailName] as? String,
              let location = dictionary[Key.location] as? String,
              let distance = dictionary[Key.distance] as? String,
              let entry = dictionary[Key.entry] as? String,
              let uuid = dictionary[Key.uuid] as? String
//              let imageURL = dictionary[Key.imageURL] as? URL
        else {return nil}
        self.init(trailName: trailName, location: location,distance: distance, entry: entry, uuid: uuid, image: nil, imageURL: nil) //image nil for now.
    }
}
