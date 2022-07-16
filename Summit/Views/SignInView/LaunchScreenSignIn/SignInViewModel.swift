//
//  SignInViewModel.swift
//  Summit
//
//  Created by Isiah Parra on 7/13/22.
//
import UIKit
import Foundation
import FirebaseAuth
import CryptoKit
import AuthenticationServices
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
    func signInWithApple( token: String, nonce: String) {
        service.signInWithApple(token: token, nonce: nonce)
    }
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }

    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    private(set) var currentNonce: String?
}
