//
//  ProfileViewController.swift
//  PoweOfThinking
//
//  Created by bora on 8.10.2020.
//

import UIKit
import Firebase
import FirebaseStorage

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gesture)

    }
    
    @objc func chooseImage()
    {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil )
        
    }
    
    
    @IBAction func UploadImage(_ sender: Any)
    {
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let medias = storageRef.child("images")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5)
        {
            let uuid = UUID().uuidString
            
            let mediareference = medias.child(uuid)
            
            mediareference.putData(data, metadata: nil) { (metadata, error) in
                if error != nil
                {
                    self.makeAlert(titleInput: "ERROR!", messageInput: error?.localizedDescription ?? "error!")
                }
                else
                {
                    mediareference.downloadURL { (url, error) in
                        if error == nil{
                            
                            //let imageUrl = url?.absoluteString
                           //  print(imageUrl)
                            self.makeAlert(titleInput: "Good Job!", messageInput: "Upload success")
                            
                        }
                    }
                    
                }
            }
            
        }
        
    }
    
    func makeAlert(titleInput: String, messageInput: String )
    {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func ExitToSignIN(_ sender: Any)
    {
        performSegue(withIdentifier: "toExitSignin", sender: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
