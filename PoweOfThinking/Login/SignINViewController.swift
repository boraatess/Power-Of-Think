//
//  SignINViewController.swift
//  PoweOfThinking
//
//  Created by bora on 6.10.2020.
//

import UIKit
import Firebase
import FirebaseAuth
import AuthenticationServices
import CryptoKit
import FBSDKLoginKit

class SignINViewController: UIViewController, LoginButtonDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var UserPasswordText: UITextField!
    @IBOutlet weak var HideButton: UIButton!
    @IBOutlet weak var UserEmailText: UITextField!
    @IBOutlet weak var UserNameText: UILabel!
    
    var newToken =  AccessToken.current
    var UserNametwo = " "
    
    private let signinButton = ASAuthorizationAppleIDButton()

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        UserEmailText.resignFirstResponder()
        UserPasswordText.resignFirstResponder()
        
        return(true)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.addSubview(signinButton)
        signinButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)

        self.UserEmailText.delegate = self
        self.UserPasswordText.delegate = self
        
        UserPasswordText.rightViewMode = .unlessEditing
        UserPasswordText.isSecureTextEntry = true
        
        if let token = AccessToken.current, !token.isExpired
        {
            let token = token.tokenString
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                     parameters: ["fields": "email, name"],
                                                     tokenString: token,
                                                     version: nil,
                                                     httpMethod: .get)
            
            request.start(completionHandler: { connection, result, error in
                print("\(String(describing: result))")
           
                if error != nil {
                    print(error ?? "error")
                    return
                  }

                  DispatchQueue.main.async {
                  self.performSegue(withIdentifier: "toMainPage", sender: nil)
                  }
                
            })
            
        }
        else{
            let loginButton = FBLoginButton()
            loginButton.frame = CGRect(x: 75, y: 720, width: 250, height: 50)
           // loginButton.setBackgroundImage(image, for: UIControl.State.normal)
                loginButton.delegate = self
                loginButton.permissions = ["public_profile", "email"]
           // loginButton = fbLoginButton as! FBLoginButton
                  view.addSubview(loginButton)
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        signinButton.frame = CGRect(x: 75, y: 650, width: 250, height: 50)
        
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                 parameters: ["fields": "email, name"],
                                                 tokenString: token,
                                                 version: nil,
                                                 httpMethod: .get)
        
        request.start(completionHandler: { connection, result, error in
            print("\(String(describing: result))")
            
            if error != nil {
                print(error ?? "error")
                return
              }

              DispatchQueue.main.async {
               self.performSegue(withIdentifier: "toMainPage", sender: nil)
              }
            
        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton)
    {
        
    }
    
    @IBAction func fbSigninClick(_ sender: Any)
    {
        
        if let token = AccessToken.current, !token.isExpired
        {
            let token = token.tokenString
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                     parameters: ["fields": "email, name"],
                                                     tokenString: token,
                                                     version: nil,
                                                     httpMethod: .get)
            
            request.start(completionHandler: { connection, result, error in
        
        guard let Info = result as? [String: Any] else { return }
        
        if let userName = Info["name"] as? String
           {
              print(userName)
           }
                print("\(String(describing: result))")

        
                if error != nil {
                    print(error ?? "error")
                    return
                  }

                  DispatchQueue.main.async {
                  self.performSegue(withIdentifier: "toMainPage", sender: nil)
                  }
                
            })
            
        }
        
    }
    
    func getUserProfile() {
        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: "/me", parameters: ["fields" : "id,name,about,birthday"],
                                    tokenString: AccessToken.current?.tokenString, version: nil, httpMethod: .get)){
            response, result, Error  in
        }
    }

    @IBAction func PasswordVisibleClicked(_ sender: Any)
    {
        
        (sender as! UIButton ).isSelected = !(sender as! UIButton).isSelected
        if (sender as! UIButton).isSelected
        {
            self.UserPasswordText.isSecureTextEntry = true
            HideButton.setImage(UIImage(named: "eye_open.png"), for: .normal)
            
        }
        else
        {
            self.UserPasswordText.isSecureTextEntry = false
            HideButton.setImage(UIImage(named: "eye_closed.png"), for: .normal)
            
        }
        
    }
    
    @IBAction func SigninToMainPage(_ sender: Any)
    {
        if UserEmailText.text != "" && UserPasswordText.text != ""
        {
            Auth.auth().signIn(withEmail: UserEmailText.text!, password: UserPasswordText.text!) { (authdate, error) in
                if error == nil
                {
                    self.performSegue(withIdentifier: "toMainPage", sender: nil)
                    
                }
                else
                {
                    self.makeAlert(titleInput: "ERROR!", messageInput: error!.localizedDescription)
                
                }
            }
            
        }
        else
        {
            makeAlert(titleInput: "ERROR!", messageInput: "Check Email or Password.")
            
        }
        
    }
    
    func makeAlert(titleInput: String, messageInput: String )
    {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func BackMainClicked(_ sender: Any)
    {
        performSegue(withIdentifier: "SignIN", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "toMainPage"
        {
           /* let tabCtrl = segue.destination as! UITabBarController
            let destinationVC = tabCtrl.viewControllers![0] as! AnaSayfaViewController
            destinationVC.userNamethree = self.UserNametwo
            */
            
        }
    }
    
    @objc func didTapSignIn(){
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }

}

extension UIViewController: ASAuthorizationControllerDelegate {
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("failed...")
    }
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            let firstName = credentials.fullName?.givenName
            let lastName = credentials.fullName?.familyName
            let email = credentials.email
            
            break
        default:
            break
        }
    }
}

extension UIViewController: ASAuthorizationControllerPresentationContextProviding {
   
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    
}
