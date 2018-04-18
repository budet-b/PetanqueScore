//
//  SelectPlayerViewController.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 18/04/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit

class SelectPlayerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var usersCollectionView: UICollectionView!
    var data: [User] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        data = NSCodingData.GetProfils()!
        print(data)
        usersCollectionView.delegate = self
        usersCollectionView.dataSource = self
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
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "select", for: indexPath) as! SelectPlayerCollectionViewCell
        let img = ImageLoad.loadImage(fileName: (data[indexPath.row].imageUrl?.path)!)
        if (img != nil) {
            print(data[indexPath.row].imageUrl?.path as! String)
            cell.userImg.image = img
            cell.userImg.layer.masksToBounds = true
            cell.userImg.layer.cornerRadius = cell.userImg.frame.size.width / 2
            cell.userImg.clipsToBounds = true
        } else {
            cell.userImg.image = UIImage(named: "profilPlaceholder")
        }
        
        cell.userName.text = data[indexPath.row].firstname
        cell.userPercent.text = "0"
        cell.nbVict.text = "12 Victoires"
        return cell
    }

}
