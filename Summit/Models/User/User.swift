//
//  UserModel.swift
//  Summit
//
//  Created by Isiah Parra on 7/2/22.
//

import Foundation

class User { // conform to equatable for deletion perhaps?
    
    enum Key {
        static var userName = "userName"
        static let id = "id"
//        static var trails = "trails"
//        static var hikes = "hikes"
        static var fireUserID = "fireUserID"
    }
    
    //MARK: Properties
    var userName: String
    var fireUserID: String
    //MARK: not saved in firestore, it has to be fetched seperatly
    //    var trails: [Trail] = [] // do not save to firestore
    //    var hikes: [Hike] = [] //  do not save to firestore
    
//    init( userName: String, trails: [Trail], hikes: [Hike], id: String, fireUserID: String) {
    init( userName: String, fireUserID: String){
        self.userName = userName
        self.fireUserID = fireUserID
    }
   
        

}
