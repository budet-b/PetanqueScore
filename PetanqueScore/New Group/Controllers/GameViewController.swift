//
//  GameViewController.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 12/04/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class GameViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var scoreEquipe1: UILabel!
    @IBOutlet weak var scoreEquipe2: UILabel!
    @IBOutlet weak var stepperEquipe1: UIStepper!
    @IBOutlet weak var stepperEquipe2: UIStepper!
    var limiteScore: Int?
    var equipe1: [User]?
    var equipe2: [User]?
    var gameObject: Game?
    var equipe1Name: String = ""
    var equipe2Name: String = ""
    var games: [Game] = []
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        scoreEquipe1.text = "0"
        scoreEquipe2.text = "0"
        stepperEquipe1.minimumValue = 0.0
        stepperEquipe2.minimumValue = 0.0
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        equipe1 = gameObject?.equipe1
        equipe2 = gameObject?.equipe2
        limiteScore = gameObject?.victNumber
        equipe1Name = (gameObject?.equipe1Name)!
        equipe2Name = (gameObject?.equipe2Name)!
        games = NSCodingData.GetGames() ?? []
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func stepperEquipe1Tap(_ sender: Any) {
        scoreEquipe1.text = "\(Int(stepperEquipe1.value))"
        if (Int(stepperEquipe1.value) >= limiteScore!)
        {
            shouldFinishGame(winner: 0)
        }
    }
    
    @IBAction func stepperEquipe2Tap(_ sender: AnyObject) {
        scoreEquipe2.text = "\(Int(stepperEquipe2.value))"
        if (Int(stepperEquipe2.value) >= limiteScore!)
        {
            shouldFinishGame(winner: 1)
        }
    }
    
    @IBAction func finishGameOnClick(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func shouldFinishGame(winner: Int) {
        gameObject?.equipe1Score = Int(stepperEquipe1.value)
        gameObject?.equipe2Score = Int(stepperEquipe2.value)
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        if (winner == 0)
        {
            alert.title = "Equipe 1 à gagné !"
            alert.message = "Félicitations à \(equipe1Name)"
        } else {
            alert.title = "Equipe 2 à gagné !"
            alert.message = "Félicitations à \(equipe2Name)"
        }
        alert.addAction(UIAlertAction(title: "Retour au menu", style: .default, handler:
            {
                (alert) -> Void in self.navigationController?.popToRootViewController(animated: true)
        }))
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            gameObject?.location = locationManager.location?.coordinate
        }
        games.append(gameObject!)
        _ = NSCodingData.SaveGame(games: games)
        self.present(alert, animated: true)
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
