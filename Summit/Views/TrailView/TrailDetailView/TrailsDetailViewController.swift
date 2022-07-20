//
//  trailsDetailViewController.swift
//  Summit
//
//  Created by Isiah Parra on 7/7/22.
//

import UIKit

class TrailsDetailViewController: UIViewController {
    
    @IBOutlet weak var decriptionLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var trailNameLabel: UILabel!
    var viewModel: TrailDetailViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        decriptionLabel.text = viewModel.description
        distanceLabel.text = viewModel.distance
        locationLabel.text = viewModel.location
        trailNameLabel.text = viewModel.trailName
    }
    
    

    
}
