//
//  GameViewController.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 12/04/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreEquipe1.text = "0"
        scoreEquipe2.text = "0"
        stepperEquipe1.minimumValue = 0.0
        stepperEquipe2.minimumValue = 0.0
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        equipe1 = gameObject?.equipe1
        equipe2 = gameObject?.equipe2
        limiteScore = gameObject?.victNumber
        equipe1Name = (gameObject?.equipe1Name)!
        equipe2Name = (gameObject?.equipe2Name)!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func stepperEquipe1Tap(_ sender: Any) {
        scoreEquipe1.text = "\(Int(stepperEquipe1.value))"
        if (Int(stepperEquipe1.value) >= limiteScore!)
        {
            print("Equipe 1 a gagné")
            let alert = UIAlertController(title: "Equipe 1 a gagné !", message: "Félicitations à \(equipe1Name)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Retour au menu", style: .default, handler:
                {
                    (alert) -> Void in self.navigationController?.popToRootViewController(animated: true)
                    
                }))
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func stepperEquipe2Tap(_ sender: AnyObject) {
        scoreEquipe2.text = "\(Int(stepperEquipe2.value))"
        if (Int(stepperEquipe2.value) >= limiteScore!)
        {
            print("Equipe 2 a gagné")
            let alert = UIAlertController(title: "Equipe 2 a gagné !", message: "Félicitations à \(equipe2Name)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Retour au menu", style: .default, handler:
                {
                    (alert) -> Void in self.navigationController?.popToRootViewController(animated: true)
                    
                }))
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func finishGameOnClick(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
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
