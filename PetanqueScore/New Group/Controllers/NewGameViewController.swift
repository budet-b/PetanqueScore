//
//  NewGameViewController.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 13/04/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit

class NewGameViewController: UIViewController {
    // TextFields
    @IBOutlet weak var Equipe2TextField: UITextField!
    @IBOutlet weak var Equipe1TextField: UITextField!
    
    // Pickers Equipe 1
    
    @IBOutlet weak var picker1_1: UIPickerView!
    @IBOutlet weak var picker1_2: UIPickerView!
    @IBOutlet weak var picker1_3: UIPickerView!
    // Pickers Equipe 2
    
    @IBOutlet weak var picker2_1: UIPickerView!
    @IBOutlet weak var picker2_2: UIPickerView!
    @IBOutlet weak var picker2_3: UIPickerView!
    
    var data: [User]?
    
    @IBAction func CreateGame(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        data = NSCodingData.GetProfils()
        picker1_1.delegate = self
        picker1_1.dataSource = self
        
        picker1_2.delegate = self
        picker1_2.dataSource = self
        
        picker1_3.delegate = self
        picker1_3.dataSource = self
        
        picker2_1.delegate = self
        picker2_1.dataSource = self
        
        picker2_2.delegate = self
        picker2_2.dataSource = self
        
        picker2_3.delegate = self
        picker2_3.dataSource = self

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

extension NewGameViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (data?.count)!
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data![row].firstname
    }
}
