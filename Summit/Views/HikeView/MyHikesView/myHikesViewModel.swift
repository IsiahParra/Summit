//
//  myHikesViewModel.swift
//  Summit
//
//  Created by Isiah Parra on 7/7/22.
//

import Foundation
protocol MyHikeViewModelDelegate: AnyObject {
    func myHikeLoadedSuccessfully()
}
class MyHike {
    var hike: Hike?
    // needing a service from firebase
    private weak var delegate: MyHikeViewModelDelegate?
    
    // ill need the firebase syncable and service for dependency injection
    func loadMyHikeData() {
        
    }
    func searchForMyHike() {
        
    }
    func deleteMyHike() {
        
    }
}// end of class
