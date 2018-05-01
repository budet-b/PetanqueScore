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
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondeLabel: UILabel!
    
    
    var limiteScore: Int?
    var equipe1: [User]?
    var equipe2: [User]?
    var gameObject: Game?
    var equipe1Name: String = ""
    var equipe2Name: String = ""
    var games: [Game] = []
    let locationManager = CLLocationManager()
    var count = 0
    var minute = 0
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        scoreEquipe1.text = "0"
        scoreEquipe2.text = "0"
        stepperEquipe1.minimumValue = 0.0
        stepperEquipe2.minimumValue = 0.0
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        minuteLabel.text = "00 :"
        secondeLabel.text = "00"
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
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.counter), userInfo: nil, repeats: true)
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
        let users = NSCodingData.GetProfils()!
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        if (winner == 0)
        {
            alert.title = "Equipe 1 à gagné !"
            alert.message = "Félicitations à \(equipe1Name)"
            for player in (gameObject?.equipe1)! {
                for user in users {
                    if player.firstname == user.firstname && player.lastname == user.lastname {
                        user.nbrVictoire! += 1
                    }
                }
            }
        } else {
            alert.title = "Equipe 2 à gagné !"
            alert.message = "Félicitations à \(equipe2Name)"
            for player in (gameObject?.equipe2)! {
                for user in users {
                    if player.firstname == user.firstname && player.lastname == user.lastname {
                        user.nbrVictoire! += 1
                    }
                }
            }
        }
        
        for player in (gameObject?.equipe1)! {
            for user in users {
                if player.firstname == user.firstname && player.lastname == user.lastname {
                    user.totalGames! += 1
                }
            }
        }

        for player in (gameObject?.equipe2)! {
            for user in users {
                if player.firstname == user.firstname && player.lastname == user.lastname {
                    user.totalGames! += 1
                }
            }
        }
        
        alert.addAction(UIAlertAction(title: "Retour au menu", style: .default, handler:
            {
                (alert) -> Void in self.navigationController?.popToRootViewController(animated: true)
        }))
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            gameObject?.latitude = locationManager.location?.coordinate.latitude
            gameObject?.longitude = locationManager.location?.coordinate.longitude
        }
        games.append(gameObject!)
        let val = NSCodingData.SaveGame(games: games)
        NSCodingData.Save(profiles: users)
        self.present(alert, animated: true)
    }
    
    @objc func counter() {
        count += 1
        if count > 9 {
            secondeLabel.text = "\(count)"
            if count == 60 {
                count = 0
                secondeLabel.text = "00"
                minute += 1
                if minute > 9 {
                    minuteLabel.text = "\(minute) :"
                }
                else{
                    minuteLabel.text = "0\(minute) :"
                }
            }
        }
        else {
            secondeLabel.text = "0\(count)"
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
