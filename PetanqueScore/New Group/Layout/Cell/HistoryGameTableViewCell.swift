//
//  HistoryGameTableViewCell.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 30/04/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit

class HistoryGameTableViewCell: UITableViewCell {

    @IBOutlet weak var team1Name: UILabel!
    @IBOutlet weak var team1Score: UILabel!
    
    @IBOutlet weak var team2Score: UILabel!
    @IBOutlet weak var team2Name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
