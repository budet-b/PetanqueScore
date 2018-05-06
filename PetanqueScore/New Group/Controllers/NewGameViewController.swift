//
//  NewGameViewController.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 13/04/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit

class NewGameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return competitions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: competitions[row], attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        
        return attributedString
    }
    
    
    @IBOutlet weak var competitionPicker: UIPickerView!
    
    @IBOutlet weak var lieuTextField: UITextField!
    // TextFields
    @IBOutlet weak var Equipe2TextField: UITextField!
    @IBOutlet weak var Equipe1TextField: UITextField!
    @IBOutlet weak var equipe1collectionView: UICollectionView!
    @IBOutlet weak var equipe2collectionView: UICollectionView!
    
    var data: [User]?
    var equipe1: [User] = []
    var equipe2: [User] = []
    var competitions: [String] = ["Championnat", "Concours Officiel", "Concours Sauvage", "Partie d'interêt", "Entre amis"]
    
    @IBOutlet weak var limiteScore: UISegmentedControl!
    @IBOutlet weak var selectFirstTeam: UIButton!
    
    
    @IBAction func selectFirstTeamOnClick(_ sender: Any) {
        guard let vc2 = storyboard?.instantiateViewController(withIdentifier: "SelectPlayer") else {
            return
        }
        UserDefaults.standard.setValue("Equipe1", forKey: "Equipe")
        navigationController?.pushViewController(vc2, animated: true)
    }
    
    
    @IBOutlet weak var selectSecondTeam: UIButton!
    
    @IBAction func selectSecondTeamOnClick(_ sender: Any) {
        guard let vc2 = storyboard?.instantiateViewController(withIdentifier: "SelectPlayer") else {
            return
        }
        UserDefaults.standard.setValue("Equipe2", forKey: "Equipe")
        navigationController?.pushViewController(vc2, animated: true)
    }
    
    @IBAction func CreateGame(_ sender: Any) {
        if (equipe1.isEmpty || (Equipe1TextField.text?.isEmpty)! || equipe2.isEmpty || (Equipe2TextField.text?.isEmpty)!)
        {
            let alert = UIAlertController(title: "Erreur dans la création de partie", message: "Merci de renseigner les équipes avec les joueurs et les noms.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "GameController") as? GameViewController else {
            return
        }
        let maxScore = Int(limiteScore.titleForSegment(at: limiteScore.selectedSegmentIndex)!)
        let newGame = Game(equipe1: equipe1, equipe2: equipe2, victNumber: maxScore!, equipe1Name: Equipe1TextField.text!, equipe2Name: Equipe2TextField.text!, equipe1Score: 0, equipe2Score: 0, longitude: nil, latitude: nil)
        vc.gameObject = newGame
        navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        data = NSCodingData.GetProfils()
        equipe1collectionView.restorationIdentifier = "Equipe1"
        Equipe2TextField.delegate = self
        Equipe1TextField.delegate = self
        Equipe.equipe1 = []
        Equipe.equipe2 = []
        equipe1collectionView.delegate = self
        equipe1collectionView.dataSource = self
        equipe2collectionView.delegate = self
        equipe2collectionView.dataSource = self
        competitionPicker.dataSource = self
        competitionPicker.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        equipe1 = Equipe.equipe1
        equipe2 = Equipe.equipe2
        equipe1collectionView.reloadData()
        equipe2collectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.restorationIdentifier == "Equipe1" {
            return equipe1.count
        } else {
            return equipe2.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfilSelectedGame", for: indexPath) as! ProfilSelectedGameCollectionViewCell
        if collectionView == equipe1collectionView {
            if collectionView.restorationIdentifier == "Equipe1" {
                equipe1 = Equipe.equipe1
                do {
                    if ((equipe1[indexPath.row].imageUrl) != nil) {
                        if let img = try ImageLoad.loadImage(fileName: (equipe1[indexPath.row].imageUrl?.path)!) {
                            cell.userImg.image = img
                        } else {
                            cell.userImg.image = UIImage(named: "profilPlaceholder")
                        }
                    } else {
                        cell.userImg.image = UIImage(named: "profilPlaceholder")
                    }
                } catch {
                    cell.userImg.image = UIImage(named: "profilPlaceholder")
                }
                cell.userImg.layer.masksToBounds = true
                cell.userImg.layer.cornerRadius = cell.userImg.frame.size.width / 2
                cell.userImg.clipsToBounds = true
                cell.userName.text = equipe1[indexPath.row].firstname
            }
        }
        else if collectionView == equipe2collectionView {
            equipe2 = Equipe.equipe2
            do {
                if ((equipe2[indexPath.row].imageUrl) != nil) {
                    let img = try ImageLoad.loadImage(fileName: (equipe2[indexPath.row].imageUrl?.path)!)
                    cell.userImg.image = img
                } else {
                    cell.userImg.image = UIImage(named: "profilPlaceholder")
                }
            } catch {
                cell.userImg.image = UIImage(named: "profilPlaceholder")
            }
            cell.userImg.layer.masksToBounds = true
            cell.userImg.layer.cornerRadius = cell.userImg.frame.size.width / 2
            cell.userImg.clipsToBounds = true
            cell.userName.text = equipe2[indexPath.row].firstname
        }
        return cell
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? GameViewController {
            vc.equipe1 = equipe1
            vc.equipe2 = equipe2
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}

extension NewGameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
