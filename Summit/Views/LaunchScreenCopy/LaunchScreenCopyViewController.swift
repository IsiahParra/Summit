//
//  LaunchScreenCopyViewController.swift
//  Summit
//
//  Created by Isiah Parra on 7/12/22.
//

import UIKit
import FirebaseAuth

class LaunchScreenCopyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        try! Auth.auth().signOut()
        print("")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //TODO: refactor and sign in with apple
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "ToTabBar", sender: self)
        } else {
            performSegue(withIdentifier: "ToSignInScreen", sender: self)
            
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue)
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
