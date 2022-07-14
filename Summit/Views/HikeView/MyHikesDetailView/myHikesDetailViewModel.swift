//
//  myHikesDetailViewModel.swift
//  Summit
//
//  Created by Isiah Parra on 7/7/22.
//

import Foundation

class MyHikesViewModel {
    var hike: Hike?
    init(hike: Hike? = nil) {
        self.hike = hike
    }
    func updateHike(with name: String, location: String, entry: String, distance: Double, date: Date = Date(), completionTime: Double, rating: Int, imageURL:URL?) {
        guard let hike = hike else { return }
    hike.hikeName = name
    hike.entry = entry
    hike.location = location
    hike.distance = distance
    hike.date = date
    hike.completionTime = completionTime
    hike.imageURL = imageURL
    }
    func fetchImageForHike() {
        
    }
}
