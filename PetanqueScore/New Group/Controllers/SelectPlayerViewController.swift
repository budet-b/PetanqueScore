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
        data = NSCodingData.GetProfils()!
//        self.navigationController?.navigationItem.hidesBackButton = true
//        self.navigationItem.hidesBackButton = true
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        //performSegue(withIdentifier: "NewGame", sender: self)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewGame" {
            if let vc = segue.destination as? NewGameViewController {
                guard let tmp = UserDefaults.standard.string(forKey: "Equipe") else {
                    return
                }
                if tmp == "Equipe1" {
                    vc.equipe1 = selectedPlayer
                }
                else if tmp == "Equipe2" {
                    vc.equipe2 = selectedPlayer
                }
            }
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableV", for: indexPath) as! SelectPlayerTableViewCell
        cell.userName.text = data[indexPath.row].firstname
        cell.userVic.text = "12 victoires"
        cell.userPercent.text = "30%"
        let img = ImageLoad.loadImage(fileName: (data[indexPath.row].imageUrl?.path)!)
        if (img != nil) {
            cell.userImg.image = img
        } else {
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
        for item in data {
            if item == data[indexPath.row] {
                selectedPlayer.remove(at: i)
            }
            i += 1
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableV", for: indexPath) as! SelectPlayerTableViewCell
        selectedPlayer.append(data[indexPath.row])
    }
}
