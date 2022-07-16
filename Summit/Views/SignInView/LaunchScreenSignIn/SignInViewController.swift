//
//  SignInViewController.swift
//  Summit
//
//  Created by Isiah Parra on 7/8/22.
//

import UIKit
import SwiftUI
import CryptoKit
import AuthenticationServices

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var viewModel: SignInViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SignInViewModel(delegate: self)
    }
    
    
    @IBAction func createAccountTapped(_ sender: Any) {
        
        //TODO: The only thing this button should do is send you to the create account screen
        // Create coustom user model (initilize it)
        // write a func that saves User to firestore
    }
    @IBAction func signInButtonTapped(_ sender: Any) {
        if emailAddressTextField.text?.isEmpty == true {
            print("No text entered in email text box")
            let alertController = UIAlertController(title: "Error has occured, Email text field empty", message: "Please enter a vaild Email", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(confirmAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        // where my previous AUTH was
        if passwordTextField.text?.isEmpty == true {
            print("No text entered in password text box")
            let alertController = UIAlertController(title: "Error has occured, Password text field is empty", message: "Please enter a valid password", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(confirmAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let password = passwordTextField.text,
              let email = emailAddressTextField.text else { return }
        viewModel.signIn(with: email, password: password)
        let storyboard = UIStoryboard(name: "TabBarController", bundle: nil)
        guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarMain") as? UITabBarController else { return }
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(viewController: tabBarController)
    }
    @IBAction func signInWithAppleTapped(_ sender: Any) {
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
    // TODO: need a Nonce
    
    // TODO: need a function to check the User Info
    // check if a UID exists if so send them to the homeScreen else show the login screen as normal
    
    //TODO: Create a login button tapped or sign in button
    //Auth.auth().signIn(with email. and password) - pass those in the parameter
    //switch the result of that
    // .none pops up an alert controller .some will take you to the homescreen
    
    //TODO: Sign in with apple function and action
    //need to preform a signInWithApple function
    
    //TODO: Build a reset password view
    //
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}// end of class


extension SignInViewController: SignInViewModelDelegate {
    func presentAlertController(error: Error) {
        let alertController = UIAlertController(title: "No account found", message: "Please check email and password", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(confirmAction)
        present(alertController, animated: true)
    }
    
    func userSignedIn() {
        let storyboard = UIStoryboard(name: "TabBarController", bundle: nil)
        guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarMain") as? UITabBarController else { return }
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(viewController: tabBarController)
    }
}
extension SignInViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
        
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = viewModel.currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: (appleIDToken.debugDescription)")
                return
            }
            viewModel.signInWithApple(token: idTokenString, nonce: nonce)
        }
    }
}

