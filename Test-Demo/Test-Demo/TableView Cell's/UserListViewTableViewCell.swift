//
//  UserListViewTableViewCell.swift
//  Test-Demo
//
//  Created by wanderer on 2/28/21.
//  Copyright © 2021 wanderer. All rights reserved.
//

import UIKit

class UserListViewTableViewCell: UITableViewCell {

    @IBOutlet weak var userBackgroundView: UIView!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userBackgroundView.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
