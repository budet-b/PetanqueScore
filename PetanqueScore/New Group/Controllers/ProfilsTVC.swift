//
//  ProfilsTVC.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 18/04/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit

class ProfilsTVC: UITableViewController {

    var data: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = NSCodingData.GetProfils() ?? []
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        data = NSCodingData.GetProfils() ?? []
        tableView.reloadData()
    }
    
    @objc func addTapped() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateProfile") as? CreateProfilViewController
        navigationController?.pushViewController(vc!, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfilCell", for: indexPath) as! ProfileTableViewCell
        if (data[indexPath.row].imageUrl?.path) != nil {
            if let img = ImageLoad.loadImage(fileName: (data[indexPath.row].imageUrl?.path)!) {
                cell.imgUser.image = img
            } else {
                cell.imgUser.image = UIImage(named: "profilPlaceholder")
            }
        }
        else {
            cell.imgUser.image = UIImage(named: "profilPlaceholder")
        }
        cell.imgUser.layer.masksToBounds = true
        cell.imgUser.layer.cornerRadius = cell.imgUser.frame.size.width / 2
        cell.imgUser.clipsToBounds = true
        cell.nomUser.text = data[indexPath.row].lastname
        cell.prenomUser.text = data[indexPath.row].firstname
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            _ = NSCodingData.Save(profiles: data)
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ProfilDetail") as? ProfilDetailViewController else {
            return
        }
        vc.idPlayer = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    
    // Override to support conditional rearranging of the table view.
   /* override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    } */
 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
