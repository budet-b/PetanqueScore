//
//  DashboardViewController.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 17/04/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var historiqueGames: UITableView!
    var games: [Game] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historiqueGames.dataSource = self
        historiqueGames.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        games = NSCodingData.GetGames() ?? []
        historiqueGames.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryGameCell", for: indexPath) as! HistoryGameTableViewCell
        cell.team1Name.text = games[indexPath.row].equipe1Name
        cell.team2Name.text = games[indexPath.row].equipe2Name
        let score1 = String(games[indexPath.row].equipe1Score!)
        let score2 = String(games[indexPath.row].equipe2Score!)
        cell.team1Score.text = "\(score1)"
        cell.team2Score.text = "\(score2)"
        if (games[indexPath.row].equipe1Score! > games[indexPath.row].equipe2Score!)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResumeGame") as? ResumeGameViewController
        vc?.idGame = indexPath.row
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
