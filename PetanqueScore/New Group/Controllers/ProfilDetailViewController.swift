//
//  ProfilDetailViewController.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 01/05/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit

class ProfilDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(indexPath)
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "champ1", for: indexPath) as! ProfilDetailCollectionViewCell
            cell.champName.text = "Championnat"
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "champ2", for: indexPath) as! ProfilDetailCollectionViewCell
            cell.champName.text = "Concours Officiel"
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "champ3", for: indexPath) as! ProfilDetailCollectionViewCell
            cell.champName.text = "Concours Sauvage"
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "champ4", for: indexPath) as! ProfilDetailCollectionViewCell
            cell.champName.text = "Partie d'interet"
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "champ5", for: indexPath) as! ProfilDetailCollectionViewCell
            cell.champName.text = "Entre amis"
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "champ1", for: indexPath) as! ProfilDetailCollectionViewCell
            return cell
        }
    }
    

    var idPlayer: Int = 0
    var players: [User] = []
    var games: [Game] = []
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var gamesCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gamesCollectionView.delegate = self
        gamesCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        players = NSCodingData.GetProfils()!
        games = NSCodingData.GetGames()!
        let curr = players[idPlayer]
        nameLabel.text = curr.firstname
        let urlImg = curr.imageUrl?.path
        if urlImg != nil {
            if let img = ImageLoad.loadImage(fileName: urlImg!) {
                imageUser.image = img
            } else {
                imageUser.image = UIImage(named: "profilPlaceholder")
            }
        } else {
            imageUser.image = UIImage(named: "profilPlaceholder")
        }
        imageUser.layer.masksToBounds = true
        imageUser.layer.cornerRadius = imageUser.frame.size.width / 2
        imageUser.clipsToBounds = true
        lastnameLabel.text = curr.lastname
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
