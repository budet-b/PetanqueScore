//
//  ResumeGameViewController.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 01/05/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//
import MapKit
import UIKit

class ResumeGameViewController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource
{


    var idGame: Int = 0
    var games: [Game] = []
    @IBOutlet weak var equipe1Name: UILabel!
    @IBOutlet weak var score1Name: UILabel!
    @IBOutlet weak var equipe1CollectionView: UICollectionView!
    
    @IBOutlet weak var equipe2Name: UILabel!
    @IBOutlet weak var score2Name: UILabel!
    @IBOutlet weak var equipe2CollectionView: UICollectionView!
    @IBOutlet weak var gameLocation: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        games = NSCodingData.GetGames()!
        equipe1CollectionView.delegate = self
        equipe2CollectionView.delegate = self
        equipe1CollectionView.dataSource = self
        equipe2CollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var deleteGame: UIButton!
    
    @IBAction func deleteGamePressed(_ sender: Any) {
        games.remove(at: idGame)
        if NSCodingData.SaveGame(games: games)
        {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let currentGame = games[idGame]
        equipe1Name.text = currentGame.equipe1Name
        equipe2Name.text = currentGame.equipe2Name
        score1Name.text = String(currentGame.equipe1Score!)
        score2Name.text = String(currentGame.equipe2Score!)
        if (currentGame.longitude != nil) && (currentGame.latitude != nil) {
            let center = CLLocationCoordinate2D(latitude: currentGame.latitude!, longitude: currentGame.longitude!)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
            gameLocation.setRegion(region, animated: true)
        } else {
            gameLocation.alpha = 0.0
        }
        equipe1CollectionView.reloadData()
        equipe2CollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.restorationIdentifier == "equipe1" {
            return (games[idGame].equipe1?.count)!
        } else {
            return (games[idGame].equipe2?.count)!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentGame = games[idGame]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerDetail", for: indexPath) as! GameDetailCollectionViewCell
        if collectionView == equipe1CollectionView && collectionView.restorationIdentifier == "equipe1" {
            do {
                let img = try ImageLoad.loadImage(fileName: (currentGame.equipe1![indexPath.row].imageUrl?.path)!)
                cell.playerImg.image = img
            } catch {
                cell.playerImg.image = UIImage(named: "profilPlaceholder")
            }
            cell.playerImg.layer.masksToBounds = true
            cell.playerImg.layer.cornerRadius = cell.playerImg.frame.size.width / 2
            cell.playerImg.clipsToBounds = true
            cell.playerName.text = currentGame.equipe1![indexPath.row].firstname
            cell.playerLastName.text = currentGame.equipe1![indexPath.row].lastname
        } else if collectionView == equipe2CollectionView && collectionView.restorationIdentifier == "equipe2" {
            do {
                let img = try ImageLoad.loadImage(fileName: (currentGame.equipe2![indexPath.row].imageUrl?.path)!)
                cell.playerImg.image = img
            } catch {
                cell.playerImg.image = UIImage(named: "profilPlaceholder")
            }
            cell.playerImg.layer.masksToBounds = true
            cell.playerImg.layer.cornerRadius = cell.playerImg.frame.size.width / 2
            cell.playerImg.clipsToBounds = true
            cell.playerName.text = currentGame.equipe2![indexPath.row].firstname
            cell.playerLastName.text = currentGame.equipe2![indexPath.row].lastname
        }
        
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
