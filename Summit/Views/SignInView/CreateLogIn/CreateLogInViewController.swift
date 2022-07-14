//
//  CreateLogInViewController.swift
//  Summit
//
//  Created by Isiah Parra on 7/8/22.
//

import UIKit

class CreateLogInViewController: UIViewController {

    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var viewModel: CreateLogInViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = CreateLogInViewModel(delegate: self)
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
        viewModel.createAccount(with: email, password: password)
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


}// end of class

extension CreateLogInViewController: CreateLogInViewModelDelegate {
    func presentAlertController(error: Error) {
        let alertController = UIAlertController(title: "Error", message: "(error.localizedDescription)", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Close", style: .cancel))
                present(alertController, animated: true)
    }
    
    func userSignedIn() {
        let storyboard = UIStoryboard(name: "TabBarController", bundle: nil)
        guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarMain") as? UITabBarController else { return }
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(viewController: tabBarController)
    }
    
}

