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
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreEquipe1.text = "0"
        scoreEquipe2.text = "0"
        stepperEquipe1.minimumValue = 0.0
        stepperEquipe2.minimumValue = 0.0
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func stepperEquipe1Tap(_ sender: Any) {
        scoreEquipe1.text = "\(Int(stepperEquipe1.value))"
    }
    
    @IBAction func stepperEquipe2Tap(_ sender: AnyObject) {
        scoreEquipe2.text = "\(Int(stepperEquipe2.value))"
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
