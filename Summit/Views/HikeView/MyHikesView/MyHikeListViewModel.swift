//
//  MyHikeListViewModel.swift
//  Summit
//
//  Created by Isiah Parra on 7/19/22.
//

import Foundation
protocol MyHikeListViewModelDelegate: AnyObject {
    func fetchedHikesSuccessfully()
}
class MyHikeListViewModel {
    var hikes: [Hike] = []
    private let service: FirebaseSyncable
    private weak var delegate: MyHikeListViewModelDelegate?
    
    init(service: FirebaseSyncable = FirebaseService(), delegate: MyHikeListViewModelDelegate) {
        self.service = service
        self.delegate = delegate
    }
    
    func fetchHikes() {
        service.loadHikes { result in
            switch result {
            case .success(let hikes):
                self.hikes = hikes
                self.delegate?.fetchedHikesSuccessfully()
            case .failure(let error):
                print(error)
            }
        }
    }
    func delete(index: Int) {
        let hike = hikes[index]
        hikes.remove(at: index)
        service.deleteHike(hike: hike)
    }
}
