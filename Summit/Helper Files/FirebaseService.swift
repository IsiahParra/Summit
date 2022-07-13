//
//  FirebaseService.swift
//  Summit
//
//  Created by Isiah Parra on 7/11/22.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import UIKit

enum FirebaseError: Error {
    case firebaseError(Error)
    case failedToUnwrapData
    case noDataFound
}
protocol FirebaseSyncable {
    func save(trail: Trail)
    func loadTrails(completion: @escaping (Result<[Trail], FirebaseError>) -> Void)
    func deleteTrail(trail: Trail)
    func signIn(with user: User)
    func createLogIn(with user: User)
    func save(hike: Hike)
    func loadHikes(completion: @escaping (Result<[Hike], FirebaseError>) -> Void)
    func deleteHike( hike: Hike)
    func fetchImageHike( from hike: Hike, completion: @escaping (Result<UIImage, FirebaseError>) -> Void)
    func fetchImageTrail( from trail: Trail, completion: @escaping (Result<UIImage, FirebaseError>) -> Void)
    func saveImageToTrail(_ image: UIImage, to trail: Trail, completion: @escaping () -> Void)
    func saveImageToHike(_ image: UIImage, to hike: Hike, completion: @escaping () -> Void)
}
struct FirebaseService: FirebaseSyncable {
    
    let reference = Firestore.firestore()
    let storage = Storage.storage().reference()
    
    func save(trail: Trail) {
        
    }
    
    func save(hike: Hike) {
        <#code#>
    }
    



    func loadTrails(completion: @escaping (Result<[Trail], FirebaseError>) -> Void) {
        <#code#>
    }

    func deleteTrail(trail: Trail) {
        <#code#>
    }

    func signIn(with user: User) {
        <#code#>
    }

    func createLogIn(with user: User) {
        <#code#>
    }

    func loadHikes(completion: @escaping (Result<[Hike], FirebaseError>) -> Void) {
        <#code#>
    }

    func deleteHike(hike: Hike) {
        <#code#>
    }

    func fetchImageHike(from hike: Hike, completion: @escaping (Result<UIImage, FirebaseError>) -> Void) {
        <#code#>
    }
    
    func fetchImageTrail(from trail: Trail, completion: @escaping (Result<UIImage, FirebaseError>) -> Void) {
        <#code#>
    }

    func saveImageToTrail(_ image: UIImage, to trail: Trail, completion: @escaping () -> Void) {
        <#code#>
    }
    
    func saveImageToHike(_ image: UIImage, to hike: Hike, completion: @escaping () -> Void) {
        <#code#>
    }
    

}// end of class


