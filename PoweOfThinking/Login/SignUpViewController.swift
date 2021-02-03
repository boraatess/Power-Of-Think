//
//  SignUpViewController.swift
//  PoweOfThinking
//
//  Created by bora on 6.10.2020.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var UserPassword: UITextField!
    @IBOutlet weak var UserEmail: UITextField!
    @IBOutlet weak var UserName: UITextField!
    @IBOutlet weak var PasswordHide: UIButton!
    
    var username = " "
    
    var flag1 = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.UserName.delegate = self
        self.UserEmail.delegate = self
        self.UserPassword.delegate = self
        
        UserPassword.rightViewMode = .unlessEditing
        UserPassword.isSecureTextEntry = true

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        UserEmail.resignFirstResponder()
        UserPassword.resignFirstResponder()
        UserName.resignFirstResponder()
        
        return(true)
    }
    
    @IBAction func HidePasswordClicked(_ sender: Any)
    {
        (sender as! UIButton ).isSelected = !(sender as! UIButton).isSelected
        if (sender as! UIButton).isSelected
        {
            self.UserPassword.isSecureTextEntry = true
            PasswordHide.setImage(UIImage(named: "eye_open.png"), for: .normal)
            
        }
        else
        {
            self.UserPassword.isSecureTextEntry = false
            PasswordHide.setImage(UIImage(named: "eye_closed.png"), for: .normal)
            
        }
        
    }
    
    @IBAction func CheckBox(_ sender: UIButton)
    {
        if flag1 == false
        {
            sender.setBackgroundImage(UIImage(named: "checkbox"), for: UIControl.State.normal)
            flag1 = true
        }
        else
        {
            sender.setBackgroundImage(UIImage(named: "uncheckbox"), for: UIControl.State.normal)
            flag1 = false
            
        }
    }
    
    @IBAction func SignUpClicked(_ sender: Any)
    {
        if UserEmail.text != " " && UserPassword.text != "" && flag1 == true && UserName.text != ""
        {
            Auth.auth().createUser(withEmail: UserEmail.text!, password: UserPassword.text!) { (authdate, error) in
                
                if error != nil
                {
                    self.makeAlert(titleInput: "ERROR!", messageInput: error?.localizedDescription ?? "error")
                }
                else
                {
                    self.makeAlert(titleInput: "BAŞARILI",
                                   messageInput: "Hesabınız başarıyla oluşturuldu giriş yapabilirsiniz. ")
                
                }
            }

        }
        
        else
        {
            makeAlert(titleInput: "UYARI!", messageInput: "E Mail veya şifrenizi kontrol ediniz ve kullanıcı sözleşmesini onaylayınız.")
        }
        
        
    }
    
    
    func makeAlert(titleInput: String, messageInput: String)
    {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func BackMainPage(_ sender: Any)
    {
        username = UserName.text!
        performSegue(withIdentifier: "SignUp", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "SignUp"
        {
            let destinationVC = segue.destination as! ViewController
            destinationVC.userName = username
        
        }
    }
    
}
