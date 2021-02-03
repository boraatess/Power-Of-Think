//
//  NextSigninPageViewController.swift
//  PoweOfThinking
//
//  Created by bora on 30.10.2020.
//

import UIKit

class NextSigninPageViewController: UIViewController {

    @IBOutlet weak var newVerticalSlider: UISlider!{
        didSet{
            newVerticalSlider.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))

        }

    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

      newVerticalSlider.frame = CGRect(x: 200, y: 270, width: 25, height: 400)
        
        //let minumum = UIImage.init(named: "Line 1.png")
       // let maximum = UIImage.init(named: "Line 2.png")
        
        self.newVerticalSlider.setValue(Float(Int(1)), animated: true)
        self.newVerticalSlider.backgroundColor = .systemOrange
        self.newVerticalSlider.minimumTrackTintColor = .systemOrange
        //self.newVerticalSlider.setMinimumTrackImage(minumum, for: .normal)
        self.newVerticalSlider.maximumTrackTintColor = .systemGray5
        self.newVerticalSlider.thumbTintColor = .systemOrange


    }
    
    @IBAction func SliderClick(_ sender: UISlider)
    {
        
        
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
    
  

}
