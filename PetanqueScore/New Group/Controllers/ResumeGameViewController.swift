//
//  ResumeGameViewController.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 01/05/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//
import MapKit
import UIKit

class ResumeGameViewController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate
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
