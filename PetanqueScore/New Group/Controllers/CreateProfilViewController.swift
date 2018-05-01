//
//  CreateProfilViewController.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 17/04/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit

class CreateProfilViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var prenomTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nomTextField: UITextField!
    @IBOutlet weak var bouleDesc: UITextField!

    let imagePicker = UIImagePickerController()
    var imagePath = ""
    var numberUser = NSCodingData.GetProfils()?.count ?? 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        prenomTextField.returnKeyType = .next
        prenomTextField.delegate = self
        prenomTextField.tag = 0
        nomTextField.delegate = self
        nomTextField.tag = 1
        nomTextField.returnKeyType = .done
        bouleDesc.delegate = self
        bouleDesc.text = ""
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addImagePicker(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)

    }
    
    @IBAction func confirmButton(_ sender: Any) {
        if (prenomTextField.text?.isEmpty)! || (nomTextField.text?.isEmpty)!
        {
            let alert = UIAlertController(title: "Erreur dans la création de profil", message: "Merci de renseigner les champs Prénom et Nom.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        let url = NSURL(fileURLWithPath: imagePath)
        let user = User(first: prenomTextField.text!, last: nomTextField.text!, url: url, bouleDesc: bouleDesc.text!)
        print(imagePath)
        // On get l'ensemble des profils
        var curr = NSCodingData.GetProfils()
        curr = curr == nil ? [] : curr
        // On ajoute notre profil
        curr?.append(user)
        // On ré-enregistre l'ensemble des profils
        let saved = NSCodingData.Save(profiles: curr!)
        if saved {
            navigationController?.popViewController(animated: true)
        }
        else {
            let alert = UIAlertController(title: "Erreur dans la création de profil", message: "Impossible de sauvegarder le profil.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Réessayer", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Tant pis", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let fileManager = FileManager.default
        let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let imagePathUrl = documentsPath?.appendingPathComponent("image\(String(describing: numberUser)).jpg")
        imagePath = (imagePathUrl?.path)!
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            try! UIImageJPEGRepresentation(pickedImage, 0.0)?.write(to: imagePathUrl!)
            imageView.image = pickedImage
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = imageView.frame.size.width / 2
            imageView.clipsToBounds = true
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion:nil)
    }
}

extension CreateProfilViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            return true;
        }
        return false
    }
}
