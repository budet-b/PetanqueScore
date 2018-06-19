//
//  ProfilDetailViewController.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 01/05/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit

class ProfilDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var deleteButtonOutlet: UIButton!
    var idPlayer: Int = 0
    var players: [User] = []
    var currentUser: User?
    var games: [Game] = []
    var gamesChampionnat: [Game] = []
    var concoursOfficielChampionnat: [Game] = []
    var concoursSauvageChampionnat: [Game] = []
    var partieDinteretChampionnat: [Game] = []
    var entreAmisChampionnat: [Game] = []
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var gamesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gamesCollectionView.delegate = self
        gamesCollectionView.dataSource = self
        
        deleteButtonOutlet.layer.cornerRadius = 10
        deleteButtonOutlet.layer.borderWidth = 1
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gamesChampionnat = []
        concoursSauvageChampionnat = []
        concoursOfficielChampionnat = []
        entreAmisChampionnat = []
        partieDinteretChampionnat = []
        players = NSCodingData.GetProfils()!
        currentUser = players[idPlayer]
        if let gamesArray = NSCodingData.GetGames() {
            games = gamesArray
        } else {
            games = []
        }
        
        for game in games {
            var isEquipe1 = false
            var isEquipe2 = false
            for player in game.equipe1! {
                if player.firstname == currentUser?.firstname && player.lastname == currentUser?.lastname {
                    isEquipe1 = true
                }
            }
            
            for player in game.equipe2! {
                if player.firstname == currentUser?.firstname && player.lastname == currentUser?.lastname {
                    isEquipe2 = true
                }
            }
            
            if ((isEquipe1 || isEquipe2) && game.competitionType == 0) {
                gamesChampionnat.append(game)
            } else if ((isEquipe1 || isEquipe2) && game.competitionType == 1) {
                concoursOfficielChampionnat.append(game)
            } else if ((isEquipe1 || isEquipe2) && game.competitionType == 2) {
                concoursSauvageChampionnat.append(game)
            } else if ((isEquipe1 || isEquipe2) && game.competitionType == 3) {
                partieDinteretChampionnat.append(game)
            } else if ((isEquipe1 || isEquipe2) && game.competitionType == 4) {
                entreAmisChampionnat.append(game)
            }
        }
        
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gamesCVCell", for: indexPath) as! ProfilDetailCollectionViewCell
        switch indexPath.row {
        case 0:
            cell.champName.text = "Championnat"
            cell.gamesArray = gamesChampionnat
            cell.nbrGames.text = String(gamesChampionnat.count)
        case 1:
            cell.champName.text = "Concours Officiel"
            cell.gamesArray = concoursOfficielChampionnat
            cell.nbrGames.text = String(concoursOfficielChampionnat.count)
        case 2:
            cell.champName.text = "Concours Sauvage"
            cell.gamesArray = concoursSauvageChampionnat
            cell.nbrGames.text = String(concoursSauvageChampionnat.count)
        case 3:
            cell.champName.text = "Partie d'interet"
            print(partieDinteretChampionnat.count)
            cell.gamesArray = partieDinteretChampionnat
            cell.nbrGames.text = String(partieDinteretChampionnat.count)
        case 4:
            cell.champName.text = "Entre amis"
            cell.gamesArray = entreAmisChampionnat
            cell.nbrGames.text = String(entreAmisChampionnat.count)
        default:
            cell.champName.text = "Championnat"
            cell.gamesArray = gamesChampionnat
            cell.nbrGames.text = String(gamesChampionnat.count)
        }
        cell.historyTableView.reloadData()
        return cell
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
