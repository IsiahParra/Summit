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
    
    
    
    
    
    func loadTrails(completion: @escaping (Result<[Trail], FirebaseError>) -> Void) {
        reference.collection( Trail.Key.collectionType).getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(FirebaseError.firebaseError(error)))
            }
            guard let data = snapshot?.documents else {
                completion(.failure(.failedToUnwrapData))
                return
            }
            // we have data now
            let dataArray = data.compactMap({$0.data()})
            // initalize a trails object from each value in the array
            let trails = dataArray.compactMap({Trail.init(fromTrailDict: $0)})
            completion(.success(trails))
        }
    }
    
    func deleteTrail(trail: Trail) {
        reference.collection(Trail.Key.collectionType).document(trail.uuid).delete()
    }
    
    func signIn(with user: User) {
        <#code#>
    }
    
    func createLogIn(with user: User) {
        <#code#>
    }
    
    func save(hike: Hike) {
        <#code#>
    }
    
    func loadHikes(completion: @escaping (Result<[Hike], FirebaseError>) -> Void) {
        reference.collection(Hike.Key.collectionType).getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(FirebaseError.firebaseError(error)))
            }
            guard let data = snapshot?.documents else {
                completion(.failure(.failedToUnwrapData))
                return
            }
            // we have data now
            let dataArray = data.compactMap({$0.data()})
            // initalize a trails object from each value in the array
            let hike = dataArray.compactMap({Hike.init(fromTrailDict: $0)})
            completion(.success(hike))
        }
    }
    
    func deleteHike(hike: Hike) {
        reference.collection(Hike.Key.collectionType).document(hike.uuid).delete()
    }
    
    func fetchImageHike(from hike: Hike, completion: @escaping (Result<UIImage, FirebaseError>) -> Void) {
        <#code#>
    }
    
    func fetchImageTrail(from trail: Trail, completion: @escaping (Result<UIImage, FirebaseError>) -> Void) {
        <#code#>
    }
    
    func saveImageToTrail(_ image: UIImage, to trail: Trail, completion: @escaping () -> Void) {
        guard let trailImageData = image.pngData() else { return }
        storage.child("images").child(trail.uuid).putData(trailImageData, metadata: nil) {_, error in
            if let error = error {
                print(error.localizedDescription)
                completion()
                return
            }
            self.storage.child("images").child(trail.uuid).downloadURL { url, error in
                if let error = error {
                    print(error.localizedDescription)
                    completion()
                    return
                }
                guard let url = url else {
                    return
                }
                trail.imageURL = url
                completion()
            }
        }
    }
    
    func saveImageToHike(_ image: UIImage, to hike: Hike, completion: @escaping () -> Void) {
        guard let hikeImageData = image.pngData() else { return }
        storage.child("images").child(hike.uuid).putData(hikeImageData, metadata: nil) {_, error in
            if let error = error {
                print(error.localizedDescription)
                completion()
                return
            }
            self.storage.child("images").child(hike.uuid).downloadURL { url, error in
                if let error = error {
                    print(error.localizedDescription)
                    completion()
                    return
                }
                guard let url = url else {
                    return
                }
                hike.imageURL = url
                completion()
            }
        }
        
    }
    
}// end of class


