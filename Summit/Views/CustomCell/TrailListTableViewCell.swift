//
//  TrailListTableViewCell.swift
//  Summit
//
//  Created by Isiah Parra on 7/17/22.
//

import UIKit

class TrailListTableViewCell: UITableViewCell {

    @IBOutlet weak var trailListImageView: UIImageView!
    @IBOutlet weak var trailNameLabel: UILabel!

    func configure(with name: String, image: UIImage?) {
        trailNameLabel.text = name
    }

}
