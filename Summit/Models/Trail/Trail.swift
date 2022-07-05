//
//  Trail.swift
//  Summit
//
//  Created by Isiah Parra on 7/2/22.
//

import Foundation
//
//class Trail {
//    //properties
//    var trailName: String
//    var location: String
//    var rating: Int
//    var date: Date
//    var distance: Double
//    var entry: String
//    var id: String
//
//enum Key {
//    static let trailName = "trailName"
//    static let location = "location"
//    static let rating = "rating"
//    static let date = "date"
//    static let distance = "distance"
//    static let entry = "entry"
//    static let id = "id"
//
//  }
//    Dictionary representation
//    var trailData: [String:AnyHashable] {
//       [Key.trailName = self.trailName,
//        Key.location = self.location,
//        Key.rating = self.rating,
//        Key.date = self.date.timeIntervalSince1970,
//        Key.distance = self.distance,
//        Key.entry = self.entry,
//        Key.id = self.id]
//    }
//    init(trailName: String, location: String, rating: Int, date: Date = Date(), distance: Double, entry: String, id: String) {
//        self.trailName = trailName
//        self.location = location
//        self.rating = rating
//        self.date = date
//        self.distance = distance
//        self.entry = entry
//        self.id = id
//    }
//    convenience init?(fromTrailDict dictionary: [String:Any]) {
//        guard let trailName = dictionary[Key.trailName] as? String,
//              let location = dictionary[Key.location] as? String,
//              let rating = dictionary[Key.rating] as? Int,
//              let date = dictionary[Key.date] as? Double,
//              let distance = dictionary[Key.distance] as? Double,
//              let entry = dictionary[Key.entry] as? String,
//              let id = dictionary[Key.id] as? String
//        else {return nil}
//        self.init(trailName: trailName, location: location, rating: rating, date: Date(timeIntervalSince1970: date), distance: distance, entry: entry, id: id)
//    }
//}
