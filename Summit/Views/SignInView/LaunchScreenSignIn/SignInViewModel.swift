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
    func presentAlertController()
}

class SignInViewModel {
    private weak var delegate: SignInViewModelDelegate?
    
    func signInAuth(with email: String, password: String) {
        //TODO: abstract firebase code to firebase service
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            switch result {
            case .none:
                self.delegate?.presentAlertController()
                
            case .some(let userDetails):
                print("Welcome back!",userDetails.user.email!)
                
                let storyboard = UIStoryboard(name: "TabBarController", bundle: nil)
                guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarMain") as? UITabBarController else { return }
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(viewController: tabBarController)
            }
        }
    }
}
