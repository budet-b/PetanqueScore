//
//  NewGameViewController.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 13/04/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit

class NewGameViewController: UIViewController {
    @IBOutlet weak var Equipe2TextField: UITextField!
    @IBOutlet weak var Equipe1TextField: UITextField!
    
    @IBAction func CreateGame(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension NewGameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == Equipe1TextField
        {
            Equipe2TextField.becomeFirstResponder()
        }
        if textField == Equipe2TextField
        {
            Equipe1TextField.resignFirstResponder()
        }
        return true
    }
}
