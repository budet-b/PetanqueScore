//
//  DashboardViewController.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 17/04/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    @IBOutlet weak var newGameOutlet: UIButton!
    @IBOutlet weak var profilesButtonOutlet: UIButton!
    
    var games: [Game] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        profilesButtonOutlet.layer.cornerRadius = 10
        profilesButtonOutlet.layer.borderWidth = 1

        newGameOutlet.layer.cornerRadius = 10
        newGameOutlet.layer.borderWidth = 1
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        games = NSCodingData.GetGames() ?? []
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fjpjpActionClicked(_ sender: Any) {

        UIApplication.shared.open(URL(string : "https://www.ffpjp.org/")!, options: [:], completionHandler: nil)
    }

    @IBAction func cd29ActionClicked(_ sender: Any) {
            UIApplication.shared.open(URL(string : "http://www.petanque-finistere.fr/")!, options: [:], completionHandler: nil)
    }
    
    @IBAction func boulistenauteActionClicked(_ sender: Any) {
            UIApplication.shared.open(URL(string : "http://www.boulistenaute.com/")!, options: [:], completionHandler: nil)
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
