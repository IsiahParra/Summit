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
    func save(trail: Trail, with imageURL: String)
    func loadTrails(completion: @escaping (Result<[Trail], FirebaseError>) -> Void)
    func deleteTrail(trail: Trail)
    
}

//struct FirebaseService : FirebaseSyncable {
//    
//}
