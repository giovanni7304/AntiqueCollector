//
//  AntiqueViewController.swift
//  AntiqueCollector
//
//  Created by Terry Johnson on 9/30/16.
//  Copyright © 2016 Terry Johnson. All rights reserved.
//

import UIKit

class AntiqueViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
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

    @IBAction func cameraTapped(_ sender: AnyObject) {
        imagePicker.sourceType = .camera
    }
    
    @IBAction func addTapped(_ sender: AnyObject) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let antique = Antiques(context: context)
        antique.title   = titleTextField.text
        
        //antique.image = UIImageJPEGRepresentation(antiqueImageView.image!, 50.00) as NSData?
        antique.image = UIImagePNGRepresentation(antiqueImageView.image!) as NSData?
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    
}
