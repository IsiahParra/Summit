//
//  TrailListViewModel.swift
//  Summit
//
//  Created by Isiah Parra on 7/13/22.
//

import Foundation

protocol TrailListViewModelDelegate: AnyObject {
   func fetchedTrailsSuccessfully()
}
class TrailListViewModel {
    
    var trails: [Trail] = []
    private let service: FirebaseSyncable 
    private weak var delegate: TrailListViewModelDelegate?
    
    init(service: FirebaseSyncable = FirebaseService(), delegate: TrailListViewModelDelegate) {
        self.service = service
        self.delegate = delegate
        fetchTrails()
    }
    
    func fetchTrails() {
//        service.loadTrails(completion: completion)
        service.loadTrails { result in
            switch result {
            case .success(let trails):
                self.trails = trails
                self.delegate?.fetchedTrailsSuccessfully()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}// end of class

// fetch trails creations

// fetch trails from firestore and show them on the table view
