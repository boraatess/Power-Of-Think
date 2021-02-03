//
//  ForgotPasswordViewController.swift
//  PoweOfThinking
//
//  Created by bora on 6.10.2020.
//

import UIKit
import Firebase
import FirebaseAuth

class ForgotPasswordViewController: UIViewController {
    @IBOutlet weak var emailtext: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func BackToSignIN(_ sender: Any)
    {
        performSegue(withIdentifier: "BackToSignIN", sender: nil)
        
    }
    @IBAction func SendPassword(_ sender: Any)
    {
        Auth.auth().sendPasswordReset(withEmail: emailtext.text!) { (error) in
            if error == nil
            {
                print("send...")
                
            }
            else
            {
                print("FAİLED -\(String(describing: error?.localizedDescription))")
            }
        }
        
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
