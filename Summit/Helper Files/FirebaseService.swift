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
import FirebaseAuth

enum FirebaseError: Error {
    case firebaseError(Error)
    case failedToUnwrapData
    case noDataFound
}
protocol FirebaseSyncable {
    func save(trail: Trail)
    func loadTrails(completion: @escaping (Result<[Trail], FirebaseError>) -> Void)
    func deleteTrail(trail: Trail)
    func signIn(with email: String, password: String, completion: @escaping (Result<Bool, FirebaseError>) -> Void)
    func createAccount(with email: String, password: String, completion: @escaping (Result<Bool, FirebaseError>) -> Void )
    func save(hike: Hike)
    func loadHikes(completion: @escaping (Result<[Hike], FirebaseError>) -> Void)
    func deleteHike( hike: Hike)
    func fetchImageHike( from hike: Hike, completion: @escaping (Result<UIImage, FirebaseError>) -> Void)
    func fetchImageTrail( from trail: Trail, completion: @escaping (Result<UIImage, FirebaseError>) -> Void)
    func saveImageToTrail(_ image: UIImage, to trail: Trail, completion: @escaping () -> Void)
    func saveImageToHike(_ image: UIImage, to hike: Hike, completion: @escaping () -> Void)
    func signOut(With user: User)
}
struct FirebaseService: FirebaseSyncable {
    
    let reference = Firestore.firestore()
    let storage = Storage.storage().reference()
    
    func save(trail: Trail) {
        
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
    
    func fetchImageTrail(from trail: Trail, completion: @escaping (Result<UIImage, FirebaseError>) -> Void) {
        
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

    func signOut(With user: User) {
        
    }
    func signIn(with email: String, password: String, completion: @escaping (Result<Bool, FirebaseError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { signInResult, error in
            switch signInResult {
            case .some(let result):
                UserDefaults.standard.set(result.user.uid, forKey: "userID")
            case .none:
                if let error = error {
                    completion(.failure(.firebaseError(error)))
                }
            }
        }
    }

    func createAccount(with email: String, password: String, completion: @escaping (Result<Bool, FirebaseError>) -> Void ) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            switch authResult {
            case .some(let result):
                // i need to save the user id to user defaults
                UserDefaults.standard.set(result.user.uid, forKey: "userUID")
                // need a completion of true
                completion(.success(true))
            case .none:
                if let error = error {
                    // need to complete false in the case none
                    completion(.failure(.firebaseError(error)))
                }
            }
        }
    }
    
    func save(hike: Hike) {
        
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


