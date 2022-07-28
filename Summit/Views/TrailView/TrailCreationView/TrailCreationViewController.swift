//
//  TrailCreationViewController.swift
//  Summit
//
//  Created by Isiah Parra on 7/7/22.
//

import UIKit

class TrailCreationViewController: UIViewController, UINavigationControllerDelegate {

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
        
        func imageViewTapped() {
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            present(picker, animated: true)
        }
        
        func updateUI() {
            guard let trail = viewModel.trail else { return }
            trailNameTextField.text = trail.trailName
            locationTextField.text = trail.location
            trailDescriptionTextView.text = trail.entry
            viewModel.getImage(from: trail) { image in
                self.trailImageView.image = image
            }
        }
//         func setupImageView() {
//            trailImageView.contentMode = .scaleAspectFit
//            trailImageView.isUserInteractionEnabled = true
//             let tapGesture = UIGestureRecognizer(target: self, action: #selector(.trailImageView))
//            trailImageView.addGestureRecognizer(tapGesture)
//        }
        
        
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

extension TrailCreationViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) {
            guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
                return
            }
            self.trailImageView.image = image
        }
    }
}
