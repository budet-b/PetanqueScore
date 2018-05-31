//
//  ProfilDetailCollectionViewCell.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 31/05/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit

class ProfilDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profilView: UIView!
    @IBOutlet weak var champName: UILabel!
    
    @IBOutlet weak var nbrGames: UILabel!
    @IBOutlet weak var victoryNumber: UILabel!
    
    @IBOutlet weak var victoryPercent: UILabel!
    
    @IBOutlet weak var historyTableView: UITableView!
}
