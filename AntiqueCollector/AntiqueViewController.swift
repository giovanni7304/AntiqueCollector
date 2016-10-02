//
//  AntiqueViewController.swift
//  AntiqueCollector
//
//  Created by Terry Johnson on 9/30/16.
//  Copyright © 2016 Terry Johnson. All rights reserved.
//

import UIKit

class AntiqueViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var addupdatebtn: UIButton!
    @IBOutlet weak var antiqueImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    var antique : Antiques? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        
        if antique != nil {
            antiqueImageView.image = UIImage(data: antique!.image as! Data)
            titleTextField.text = antique!.title
            addupdatebtn.setTitle("Update", for: .normal)
        } else {
            deleteBtn.isHidden = true
        }
        
        self.titleTextField.delegate = self
    }

    @IBAction func photosTapped(_ sender: AnyObject) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        antiqueImageView.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    @IBAction func cameraTapped(_ sender: AnyObject) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: AnyObject) {
        
        if antique != nil {
            antique!.title   = titleTextField.text
            antique!.image = UIImagePNGRepresentation(antiqueImageView.image!) as NSData?
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let antique = Antiques(context: context)
            antique.title   = titleTextField.text
            //antique.image = UIImageJPEGRepresentation(antiqueImageView.image!, 50.00) as NSData?
            antique.image = UIImagePNGRepresentation(antiqueImageView.image!) as NSData?
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func deleteTapped(_ sender: AnyObject) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(antique!)
    
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
}
