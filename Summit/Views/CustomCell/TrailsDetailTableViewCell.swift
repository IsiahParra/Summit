//
//  TrailsDetailTableViewCell.swift
//  Summit
//
//  Created by Isiah Parra on 7/18/22.
//

import UIKit

class TrailsDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var trailNameLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var trailDetailImageView: UIImageView!
    
    
    func configure( trail: Trail , name: String, location: String, description: String, date: Date = Date(), distance: String, image: UIImage?) {
        trailNameLabel.text = name
        locationLabel.text = location
        descriptionLabel.text = description
        dateLabel.text = trail.timeStamp.stringValue()
        distanceLabel.text = distance
        
    }
    
    
    
    
    
    
}
