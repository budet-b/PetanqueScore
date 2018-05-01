//
//  ProfilDetailViewController.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 01/05/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit

class ProfilDetailViewController: UIViewController {

    var idPlayer: Int = 0
    var players: [User] = []
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
    
    @IBOutlet weak var nbrGames: UILabel!
    @IBOutlet weak var percentVictory: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    
    @IBOutlet weak var bouleDetail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        players = NSCodingData.GetProfils()!
        let curr = players[idPlayer]
        nameLabel.text = curr.firstname
        if let img = ImageLoad.loadImage(fileName: (curr.imageUrl?.path)!) {
            imageUser.image = img
        } else {
            imageUser.image = UIImage(named: "profilPlaceholder")
        }
        imageUser.layer.masksToBounds = true
        imageUser.layer.cornerRadius = imageUser.frame.size.width / 2
        imageUser.clipsToBounds = true
        nbrGames.text = String(curr.totalGames!)
        lastnameLabel.text = curr.lastname
        var percentVict = 0
        if curr.totalGames == 0 {
            percentVict = 0
        } else {
            percentVict = curr.nbrVictoire! / curr.totalGames!
        }
        percentVictory.text = String(percentVict * 100)
        if percentVict > 50 {
            percentVictory.textColor = UIColor.green
        } else {
            percentVictory.textColor = UIColor.red
        }
        bouleDetail.text = curr.bouleDesc
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        players.remove(at: idPlayer)
        let res = NSCodingData.Save(profiles: players)
        if (res) {
            self.navigationController?.popToRootViewController(animated: true)
        }
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
