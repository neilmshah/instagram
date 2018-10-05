//
//  NewPostViewController.swift
//  instagram
//
//  Created by Neil Shah on 10/1/18.
//  Copyright © 2018 Neil Shah. All rights reserved.
//

import UIKit
import MBProgressHUD

class NewPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var photoSelectImageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    
    var photoSelected : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onTapPhoto(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            //print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            //print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    // Delegate Protocols
    @objc func imagePickerController(_ picker: UIImagePickerController,
                                     didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //let originalImage = info[.originalImage] as! UIImage
        let editedImage = info[.editedImage] as! UIImage
        photoSelectImageView.image = editedImage
        photoSelected = true
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sharePhoto(_ sender: UIButton) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let caption = captionTextField.text ?? ""
        let image = photoSelectImageView.image
        if (!photoSelected) {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.createAlert(title: "Photo not selected", message: "Please select a photo to share it.")
            return
        }
        Post.postUserImage(image: image, withCaption: caption) { (success, error) in
            if success {
                MBProgressHUD.hide(for: self.view, animated: true)
                self.performSegue(withIdentifier: "homeFeedSegue", sender: nil)
            } else {
                print(error?.localizedDescription)
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }
        
    }
    
    func createAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel) {(action) in}
        alertController.addAction((dismissAction))
        self.present(alertController, animated: true) { }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let vc = segue.destination as! UINavigationController;
        //let pVc = vc.viewControllers.first as! InstagramViewController
        //pVc.fetchPosts()
    }
    
}
