//
//  SignInViewController.swift
//  Summit
//
//  Created by Isiah Parra on 7/8/22.
//

import UIKit
import FirebaseAuth
import SwiftUI

class SignInViewController: UIViewController {

    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    let viewModel: SignInViewModel = SignInViewModel()
    
    
    @IBAction func createAccountTapped(_ sender: Any) {
//        if emailAddressTextField.text?.isEmpty == true {
//            print("No text entered in email text box")
//            let alertController = UIAlertController(title: "Error has occured, Email text field empty", message: "Please enter a vaild Email", preferredStyle: .alert)
//            let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
//            alertController.addAction(confirmAction)
//            self.present(alertController, animated: true, completion: nil)
//            return
//        }
//        if passwordTextField.text?.isEmpty == true {
//            print("No text entered in password text box")
//            let alertController = UIAlertController(title: "Error has occured, Password text field is empty", message: "Please enter a valid password", preferredStyle: .alert)
//            let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
//            alertController.addAction(confirmAction)
//            self.present(alertController, animated: true, completion: nil)
//            return
//        }
//        guard let password = passwordTextField.text,
//        let email = emailAddressTextField.text else { return }
//        Auth.auth().createUser(withEmail: email, password: password) { result, error in
//            let user = result?.user
//            let id = user?.uid
        //TODO: The only thing this button should do is send you to the create account screen
            // Create coustom user model (initilize it)
            // write a func that saves User to firestore
        }
    @IBAction func signInButtonTapped(_ sender: Any) {
        if let email = emailAddressTextField.text,
           let password = passwordTextField.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                switch result {
                case .none:
                    let alertController = UIAlertController(title: "No account found", message: "Please check email and password", preferredStyle: .alert)
                    let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alertController.addAction(confirmAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                case .some(let userDetails):
                    print("Welcome back!",userDetails.user.email!)
                    
                    let storyboard = UIStoryboard(name: "TabBarController", bundle: nil)
                    guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarMain") as? UITabBarController else { return }
                    tabBarController.modalPresentationStyle = .overFullScreen
                    self.emailAddressTextField.text = ""
                    self.passwordTextField.text = ""
                    self.emailAddressTextField.resignFirstResponder()
                    self.passwordTextField.resignFirstResponder()
                    self.present(tabBarController, animated: true)
                }
            }
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
    }
}

extension SignInViewController: SignInViewModelDelegate {
    func presentAlertController() {
        let alertController = UIAlertController(title: "No account found", message: "Please check email and password", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(confirmAction)
        present(alertController, animated: true)
        
    }
}
