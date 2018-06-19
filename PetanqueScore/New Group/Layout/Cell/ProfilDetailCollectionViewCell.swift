//
//  ProfilDetailCollectionViewCell.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 31/05/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit

class ProfilDetailCollectionViewCell: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var profilView: UIView!
    @IBOutlet weak var champName: UILabel!
    
    @IBOutlet weak var nbrGames: UILabel!
    @IBOutlet weak var victoryNumber: UILabel!
    
    @IBOutlet weak var victoryPercent: UILabel!
    
    @IBOutlet weak var historyTableView: UITableView!
    
    var gamesArray = [Game]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        historyTableView.delegate = self
        historyTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = historyTableView.dequeueReusableCell(withIdentifier: "HistoryGameCell") as! HistoryGameTableViewCell
        
        cell.team1Name.text = gamesArray[indexPath.row].equipe1Name
        cell.team2Name.text = gamesArray[indexPath.row].equipe2Name
        guard let scoreInt1 = gamesArray[indexPath.row].equipe1Score else {
            return cell
        }
        guard let scoreInt2 = gamesArray[indexPath.row].equipe2Score else {
            return cell
        }
        let score1 = String(scoreInt1)
        let score2 = String(scoreInt2)
        
        cell.team1Score.text = "\(score1)"
        cell.team2Score.text = "\(score2)"
        if (gamesArray[indexPath.row].equipe1Score! > gamesArray[indexPath.row].equipe2Score!)
        {
            cell.team1Score.textColor = UIColor.green
            cell.team1Name.textColor = UIColor.green
            cell.team2Score.textColor = UIColor.red
            cell.team2Name.textColor = UIColor.red
        } else {
            cell.team2Score.textColor = UIColor.green
            cell.team2Name.textColor = UIColor.green
            cell.team1Name.textColor = UIColor.red
            cell.team1Score.textColor = UIColor.red
        }
        return cell
    }
    

}
