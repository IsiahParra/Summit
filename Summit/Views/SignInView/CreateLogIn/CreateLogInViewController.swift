//
//  CreateLogInViewController.swift
//  Summit
//
//  Created by Isiah Parra on 7/8/22.
//

import UIKit
import FirebaseAuth

class CreateLogInViewController: UIViewController {

    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        if emailAddressTextField.text?.isEmpty == true {
            print("No text entered in email text box")
            let alertController = UIAlertController(title: "Error has occured, Email text field empty", message: "Please enter a vaild Email", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(confirmAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
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
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            // check for successful result
            switch result {
            case.none:
                let alertController = UIAlertController(title: "Unable to create account", message: "Please check email and password or recover your password.", preferredStyle: .alert)
                let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(confirmAction)
                self.present(alertController, animated: true, completion: nil)
            case .some(_):
                let storyboard = UIStoryboard(name: "TabBarController", bundle: nil)
                guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarMain") as? UITabBarController else { return }
                tabBarController.modalPresentationStyle = .overFullScreen
                self.present(tabBarController, animated: true, completion: nil)
                
                let user = result?.user
                UserDefaults.standard.set(user?.uid, forKey: "uid")
                print(user?.uid)
                
            }
    }
        
    // TODO: need an action for the "create Account" button tapped
    // need to make sure neither fields are empty and if they are do an alert controller to let the user know that its empty
    // calls the sign up function
    
    // TODO: Create a sign up function
    // this is the function that creates a user in firebase call Auth.auth().createUser(with email, and password)
    // set UID
    // Send to homeScreen or change view to homescreen
    
    //TODO: Password validation
    // how many characters and symbols i can use and follow firebase password rules of no spaces and minimum 6 characters
    

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
