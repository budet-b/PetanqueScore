//
//  SelectPlayerViewController.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 18/04/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit

class SelectPlayerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var validateButton: UIButton!
    @IBOutlet weak var tableViewPlayers: UITableView!
    var data: [User] = []
    var selectedPlayer: [User] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        data = NSCodingData.GetProfils() ?? []

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        
        if let viewControllers = self.navigationController?.viewControllers {
            let vc = viewControllers[viewControllers.count - 2] as! NewGameViewController
            guard let tmp = UserDefaults.standard.string(forKey: "Equipe") else {
                return
            }
            if tmp == "Equipe1" {
                Equipe.equipe1 = selectedPlayer
                vc.equipe1 = selectedPlayer
            }
            else if tmp == "Equipe2" {
                Equipe.equipe2 = selectedPlayer
                vc.equipe2 = selectedPlayer
            }
        }
        
        
        self.navigationController?.popViewController(animated: true)
        //performSegue(withIdentifier: "NewGame", sender: self)
    }
    
    
    // MARK: - Navigation
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableV", for: indexPath) as! SelectPlayerTableViewCell
        let curr = data[indexPath.row]
        cell.userName.text = curr.firstname
        var percentVict: Double = 0
        if curr.totalGames == 0 {
            percentVict = 0
        } else {
            percentVict = Double(curr.nbrVictoire!) / Double(curr.totalGames!)
        }
        cell.userPercent.text = String("\(percentVict * 100) %")
        cell.userVic.text = String(curr.nbrVictoire!)
        if percentVict > (50 / 100) {
            cell.userPercent.textColor = UIColor.green
        } else {
            cell.userPercent.textColor = UIColor.red
        }
        do {
            if ((data[indexPath.row].imageUrl) != nil) {
                let img = try ImageLoad.loadImage(fileName: (data[indexPath.row].imageUrl?.path)!)
                cell.userImg.image = img
            } else {
                cell.userImg.image = UIImage(named: "profilPlaceholder")
            }
        } catch {
            cell.userImg.image = UIImage(named: "profilPlaceholder")
        }
        cell.userImg.layer.masksToBounds = true
        cell.userImg.layer.cornerRadius = cell.userImg.frame.size.width / 2
        cell.userImg.clipsToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableV", for: indexPath) as! SelectPlayerTableViewCell
        cell.accessoryType = .none
        cell.backgroundColor = UIColor.white
        var i = 0
        for player in selectedPlayer {
            if player.firstname! == data[indexPath.row].firstname &&
                player.lastname! == data[indexPath.row].lastname {
                selectedPlayer.remove(at: i)
                return
            }
            i += 1
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableV", for: indexPath) as! SelectPlayerTableViewCell
        selectedPlayer.append(data[indexPath.row])
    }
}
