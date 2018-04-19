//
//  SelectPlayerViewController.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 18/04/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit

class SelectPlayerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewPlayers: UITableView!
    var data: [User] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        data = NSCodingData.GetProfils()!
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableV", for: indexPath) as! SelectPlayerTableViewCell
        cell.userName.text = data[indexPath.row].firstname
        cell.userVic.text = "12 victoires"
        cell.userPercent.text = "30%"
        let img = ImageLoad.loadImage(fileName: (data[indexPath.row].imageUrl?.path)!)
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
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableV", for: indexPath) as! SelectPlayerTableViewCell
        cell.accessoryType = .none
        cell.backgroundColor = UIColor.white
    }
}
