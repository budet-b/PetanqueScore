//
//  ProfileTableViewCell.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 19/04/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var nomUser: UILabel!
    @IBOutlet weak var prenomUser: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
