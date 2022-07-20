//
//  TrailHikedTableViewCell.swift
//  Summit
//
//  Created by Isiah Parra on 7/19/22.
//

import UIKit

class TrailHikedTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    
    func updateViews(with hike: Hike) {
        dateLabel.text = hike.hikeName // Temporary (Change to show the date using a date formatter)
    }

}
