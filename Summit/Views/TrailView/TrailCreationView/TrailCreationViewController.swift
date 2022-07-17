//
//  TrailCreationViewController.swift
//  Summit
//
//  Created by Isiah Parra on 7/7/22.
//

import UIKit

class TrailCreationViewController: UIViewController {

    @IBOutlet weak var trailNameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var trailDescriptionTextView: UITextView!
    @IBOutlet weak var trailImageView: UIImageView!
    
    @IBOutlet weak var distanceTextField: UITextField!
    let viewModel: TrailCreationViewModel = TrailCreationViewModel()
    
//    init(viewModel: TrailCreationViewModel) {
//        self.viewModel = viewModel
////        super.init()
//    }
//
////    required init?(coder: NSCoder) {
////        fatalError("init(coder:) has not been implemented")
////    }
//
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let trailName = trailNameTextField.text,
        let description = trailDescriptionTextView.text,
        let city = locationTextField.text,
        let distance = distanceTextField.text  else {
            return
        }
        
        viewModel.saveTrail(with: trailName, entry: description , location: city, image: trailImageView.image ,distance: distance) { result in
            switch result {
            case .success():
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            case .failure(let error):
                print(error)
            }
            
        }
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
