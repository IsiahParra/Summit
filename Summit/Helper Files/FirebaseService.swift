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
    func save(trail: Trail, with image: UIImage?, completion: @escaping (Result<Void, Error>) -> Void)
    func loadTrails(completion: @escaping (Result<[Trail], FirebaseError>) -> Void)
    func deleteTrail(trail: Trail)
    func signIn(with email: String, password: String, completion: @escaping (Result<Bool, FirebaseError>) -> Void)
    func createAccount(with email: String, password: String, completion: @escaping (Result<Bool, FirebaseError>) -> Void )
    func createTrail( with trail: Trail, completion: @escaping (Result<Trail, FirebaseError>) -> Void)
    func save(hike: Hike, with image: UIImage)
    func loadHikes(completion: @escaping (Result<[Hike], FirebaseError>) -> Void)
    func deleteHike( hike: Hike)
    func fetchImageHike( from hike: Hike, completion: @escaping (Result<UIImage, FirebaseError>) -> Void)
    func fetchImageTrail( from trail: Trail, completion: @escaping (Result<UIImage, FirebaseError>) -> Void)
//    func saveImageToTrail(_ image: UIImage, to trail: Trail, completion: @escaping () -> Void)
    func saveImageToHike(_ image: UIImage, to hike: Hike, completion: @escaping () -> Void)
    func signOut(With user: User)
    func signInWithApple( token: String, nonce: String)
}
struct FirebaseService: FirebaseSyncable {
    
    let reference = Firestore.firestore()
    let storage = Storage.storage().reference()
    
    
    func signInWithApple(token: String, nonce: String) {
        let credentials = OAuthProvider.credential(withProviderID: "apple.com", idToken: token, rawNonce: nonce)
        
        Auth.auth().signIn(with: credentials) { authResult, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("made it this far")
        }
    }
    
    
    //TODO: ASk about the createTrail func
    
        func createTrail(with trail: Trail, completion: @escaping (Result<Trail, FirebaseError>) -> Void) {
//            reference.collection(Trail.Key.collectionType).getDocuments { trailsnapshot, error in
//                if let error = error {
//                    completion(.failure(.firebaseError(error)))
//                }
//                guard let data = trailsnapshot?.documents else {
//                    completion(.failure(.failedToUnwrapData))
//                    return
//                }
//                let trailData = data.compactMap({ $0. })
//                let trails = trailData.compactMap({Trail.init(fromTrailDict: $0)})
//                completion(.success(trails))
//            }
       }
    
    func save(trail: Trail, with image: UIImage?, completion: @escaping (Result<Void, Error>) -> Void) {
//        if let image = image {
//            // save the image to storage
//
//        }
//        saveImageToTrail(image, to: trail) {
//            reference.collection(Trail.Key.collectionType).document(trail.uuid).setData(trail.trailData)
//        }
        saveTrailToFirestore(trail: trail, completion: completion)
    }
   private func saveImageToTrail(_ image: UIImage, to trail: Trail, completion: @escaping () -> Void) {
        guard let trailImageData = image.pngData() else { return }
        storage.child("images").child(trail.uuid).putData(trailImageData, metadata: nil) {_, error in
            if let error = error {
                print(error.localizedDescription)
                completion()
                return
            }
//            self.storage.child("images").child(trail.uuid).downloadURL { url, error in
//                if let error = error {
//                    print(error.localizedDescription)
//                    completion()
//                    return
//                }
//                guard let url = url else {
//                    return
//                }
//                trail.imageURL = url
//                completion()
//            }
        }
    }
    
    private func saveTrailToFirestore(trail: Trail, completion: @escaping (Result<Void, Error>) -> Void) {
        reference.collection(Trail.Key.collectionType).document(trail.uuid).setData(trail.trailData) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
//        reference.collection(Trail.Key.collectionType).addDocument(data: trail.trailData)
    }
    
    func fetchImageTrail(from trail: Trail, completion: @escaping (Result<UIImage, FirebaseError>) -> Void) {
        storage.child("images").child(trail.uuid).getData(maxSize: 1024 * 1024) { result in
            switch result {
            case .success(let data):
                guard let imageTrail = UIImage(data: data) else {
                    completion(.failure(.failedToUnwrapData))
                    return
                }
                completion(.success(imageTrail))
                
            case .failure(let error):
                completion(.failure(.firebaseError(error)))
            }
        }
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
            let trails = dataArray.compactMap({Trail(fromTrailDict: $0)})
            completion(.success(trails))
            //why can i only get 0 values when passing the dataArray?
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
    
    func save(hike: Hike, with image: UIImage) {
        saveImageToHike(image, to: hike) {
            reference.collection(Hike.Key.collectionType).document(hike.uuid).setData(hike.hikeData)
        }
        
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
        storage.child("images").child(hike.uuid).getData(maxSize: 1024 * 1024) { result in
            switch result {
            case .success(let data):
                guard let imageHike = UIImage(data: data) else {
                    completion(.failure(.failedToUnwrapData))
                    return
                }
                completion(.success(imageHike))
            case.failure(let error):
                completion(.failure(.firebaseError(error)))
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


