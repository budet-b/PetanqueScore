//
//  SelectPlayerTableViewCell.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 18/04/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit

class SelectPlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var userPercent: UILabel!
    @IBOutlet weak var userVic: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            backgroundColor = UIColor.red
            accessoryType = .checkmark
            let view = UIView()
            view.backgroundColor = UIColor(red:0.35, green:0.60, blue:0.77, alpha:1.0)
            selectedBackgroundView = view
        } else {
            backgroundColor = UIColor.white
            accessoryType = .none
        }

        // Configure the view for the selected state
    }
    
    

}
