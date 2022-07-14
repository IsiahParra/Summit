//
//  SignInViewModel.swift
//  Summit
//
//  Created by Isiah Parra on 7/13/22.
//
import UIKit
import Foundation
import FirebaseAuth

protocol SignInViewModelDelegate: AnyObject {
    func presentAlertController(error: Error)
    func userSignedIn()
}

class SignInViewModel {
    private weak var delegate: SignInViewModelDelegate?
    private let service: FirebaseSyncable
    
    init(service: FirebaseSyncable = FirebaseService(), delegate: SignInViewModelDelegate) {
        self.delegate = delegate
        self.service = service
    }
    
    func signIn(with email: String, password: String) {
        service.signIn(with: email, password: password) { result in
            switch result {
            case .success:
                self.delegate?.userSignedIn()
            case.failure(let error):
                self.delegate?.presentAlertController(error: error)
                let storyboard = UIStoryboard(name: "TabBarController", bundle: nil)
                guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarMain") as? UITabBarController else { return }
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(viewController: tabBarController)
            }
        }
    }
}
