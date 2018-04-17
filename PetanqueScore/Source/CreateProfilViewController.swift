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
    let imagePicker = UIImagePickerController()
    var imagePath = ""
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nomTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        prenomTextField.returnKeyType = .next
        prenomTextField.delegate = self
        prenomTextField.tag = 0
        nomTextField.delegate = self
        nomTextField.tag = 1
        nomTextField.returnKeyType = .done
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
            confirmButton.isEnabled = false
        }
        var url = NSURL(fileURLWithPath: imagePath)
        var user = User(first: prenomTextField.text!, last: nomTextField.text!, url: url)
        print(imagePath)
        var curr = UserDefaults.standard.array(forKey: "users")
        curr?.append(user)
        UserDefaults.standard.set(curr, forKey: "users")
        print(UserDefaults.standard.array(forKey: "users"))
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let fileManager = FileManager.default
        let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        var imagePathUrl = documentsPath?.appendingPathComponent("image.jpg")
        imagePath = (imagePathUrl?.absoluteString)!
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            try! UIImageJPEGRepresentation(pickedImage, 0.0)?.write(to: imagePathUrl!)
            imageView.image = pickedImage
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
