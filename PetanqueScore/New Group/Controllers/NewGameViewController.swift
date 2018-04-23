//
//  NewGameViewController.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 13/04/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit

class NewGameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // TextFields
    @IBOutlet weak var Equipe2TextField: UITextField!
    @IBOutlet weak var Equipe1TextField: UITextField!
    @IBOutlet weak var equipe1collectionView: UICollectionView!
    @IBOutlet weak var equipe2collectionView: UICollectionView!
    
    var data: [User]?
    var equipe1: [User] = []
    var equipe2: [User] = []
    
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
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "GameController") else {
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        data = NSCodingData.GetProfils()
        equipe1collectionView.restorationIdentifier = "Equipe1"
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
                let img = ImageLoad.loadImage(fileName: (equipe1[indexPath.row].imageUrl?.path)!)
                if (img != nil) {
                    cell.userImg.image = img
                } else {
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
            let img = ImageLoad.loadImage(fileName: (equipe2[indexPath.row].imageUrl?.path)!)
            if (img != nil) {
                cell.userImg.image = img
            } else {
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
        if textField == Equipe1TextField
        {
            Equipe2TextField.becomeFirstResponder()
        }
        if textField == Equipe2TextField
        {
            Equipe2TextField.endEditing(true)
        }
        return true
    }
}
