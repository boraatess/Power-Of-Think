//
//  ViewController.swift
//  PoweOfThinking
//
//  Created by bora on 6.10.2020.
//

import UIKit

class ViewController: UIViewController
{
    var userName = ""
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(userName)
        
        welcomeLabel.text = "Hoşgeldin!".localized()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "SigninPage"
        {
            let destinationVC = segue.destination as! SignINViewController
            destinationVC.UserNametwo = userName
        
        }
        
    }

}

extension String{
    func localized() -> String {
        return NSLocalizedString(self,
                                 tableName: "Localizable",
                                 bundle: .main,
                                 value: self,
                                 comment: self)
    }
}

