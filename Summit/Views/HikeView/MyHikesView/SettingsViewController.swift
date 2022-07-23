//
//  SettingsViewController.swift
//  Summit
//
//  Created by Isiah Parra on 7/23/22.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let viewModel: SettingsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func signoutButtonTapped(_ sender: Any) {
        viewModel.logOut()
        let storyboard = UIStoryboard(name: "SignInScreen", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "SignInView")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(viewController: loginViewController)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
