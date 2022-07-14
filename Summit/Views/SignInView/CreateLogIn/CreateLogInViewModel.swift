//
//  CreateLogInViewModel.swift
//  Summit
//
//  Created by Isiah Parra on 7/14/22.
//

import Foundation

protocol CreateLogInViewModelDelegate: AnyObject {
    func presentAlertController(error: Error)
    func userSignedIn()
}
class CreateLogInViewModel {
    
    private let service: FirebaseSyncable
    private weak var delegate: CreateLogInViewModelDelegate?
    
    init(service: FirebaseSyncable = FirebaseService(), delegate: CreateLogInViewModelDelegate) {
        self.delegate = delegate
        self.service = service
    }
    
    func createAccount(with email: String, password: String) {
        service.createAccount(with: email, password: password) { result in
            switch result {
            case .success:
                self.delegate?.userSignedIn()
                
            case .failure(let error):
                //Send an alert to user when failed
                self.delegate?.presentAlertController(error: error)
                
            }
        }
    }
}
