//
//  NewGameViewController.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 13/04/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit

class NewGameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfilSelectedGame", for: indexPath) as! ProfilSelectedGameCollectionViewCell
    
        let img = ImageLoad.loadImage(fileName: (equipe1[indexPath.row].imageUrl?.path)!)
        if (img != nil) {
            cell.userImg.image = img
        } else {
            cell.userImg.image = UIImage(named: "profilPlaceholder")
        }
        cell.userImg.layer.masksToBounds = true
        cell.userImg.layer.cornerRadius = cell.userImg.frame.size.width / 2
        cell.userImg.clipsToBounds = true
        return cell
    }
    
    // TextFields
    @IBOutlet weak var Equipe2TextField: UITextField!
    @IBOutlet weak var Equipe1TextField: UITextField!
    @IBOutlet weak var equipe1collectionView: UICollectionView!
    var data: [User]?
    var equipe1: [User] = []

    @IBAction func CreateGame(_ sender: Any) {
        let vc = GameViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        data = NSCodingData.GetProfils()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        print("Equipe1: \(equipe1.count)")
        equipe1collectionView.layoutIfNeeded()
        equipe1collectionView.reloadData()
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
