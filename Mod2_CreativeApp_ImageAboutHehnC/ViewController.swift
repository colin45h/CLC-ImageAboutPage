//
//  ViewController.swift
//  Mod2_CreativeApp_ImageAboutHehnC
//
//  Created by Tiger Coder on 9/21/20.
//  Copyright © 2020 clc.hehn. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var nameDisplayLabel: UILabel!
    @IBOutlet weak var imageStatsLabel: UILabel!
    @IBOutlet weak var imageViewMain: UIImageView!
    @IBOutlet weak var imageStackView: UIStackView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var loginStackView: UIStackView!

    var imageDisplay = UIImage(named: "gradient_py")
    var imageInsert : String = ""
    
    var userName : String = ""
    
    // On Screen Functions and Such
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        nameTextField.delegate = self
        
        imageStatsLabel.text = "Width:\nHeight:\nArea:"
        imageStackView.isHidden = true
        imageViewMain.image = imageDisplay
    }

    @IBAction func loginButton(_ sender: UIButton) {
      
        nameTextField.resignFirstResponder()

        loginStackView.isHidden = true
        imageStackView.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            self.nameDisplayLabel.text = "Now \(self.nameTextField.text!), upload an image."
        }
    }
    
    @IBAction func uploadButton(_ sender: UIButton) {
        
        let imagePick = UIImagePickerController()
        imagePick.delegate = self
        imagePick.allowsEditing = true
        imagePick.mediaTypes = ["public.image"]
        imagePick.sourceType = .photoLibrary
        
        present(imagePick, animated: true)
    }
    
    // Image + Keyboard Related Functions (Behind The Scenes)
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        imageInsert = imageName
        
        dismiss(animated: true, completion: showImageStats)
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           
           nameTextField.resignFirstResponder()
           
           return true
    }
    
    func showImageStats() -> Void {
         
            let path = getDocumentsDirectory().appendingPathComponent(imageInsert)
            imageDisplay = UIImage(contentsOfFile: path.path)
            imageViewMain.image = imageDisplay
        
            let imageHeight = (imageDisplay!.size.height)*(imageDisplay!.scale)
            let imageWidth = (imageDisplay!.size.height)*(imageDisplay!.scale)
            let imageArea = imageWidth * imageHeight
        
            nameDisplayLabel.text = "Nice! There's some stats, upload another if you want."
               
            imageStatsLabel.text = "Width: \(imageWidth) pixels\nHeight: \(imageHeight) pixels\nArea: \(imageArea) pixels"
     }
}

