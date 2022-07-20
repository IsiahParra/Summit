//
//  trailsDetailViewController.swift
//  Summit
//
//  Created by Isiah Parra on 7/7/22.
//

import UIKit

class TrailsDetailViewController: UIViewController {
    
    @IBOutlet weak var hikesTableView: UITableView!
    @IBOutlet weak var decriptionLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var trailNameLabel: UILabel!
    
    var viewModel: TrailDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hikesTableView.dataSource = self
        updateViews()
    }
    
    func updateViews() {
        decriptionLabel.text = viewModel.description
        distanceLabel.text = viewModel.distance
        locationLabel.text = viewModel.location
        trailNameLabel.text = viewModel.trailName
    }
    
    
    //prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    // pass the trail to the hike tracking page
    
}

extension TrailsDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfHikes
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "hikedTrailCell", for: indexPath) as? TrailHikedTableViewCell
        else { return UITableViewCell() }
        
        let hike = viewModel.hike(at: indexPath.row)
        
        cell.updateViews(with: hike)
        return cell
    }
}
