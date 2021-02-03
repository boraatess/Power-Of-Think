//
//  SoulStatusViewController.swift
//  PoweOfThinking
//
//  Created by bora on 21.10.2020.
//

import UIKit

class SoulStatusViewController: UIViewController
{
    
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var verticalSlider: UISlider!{
        didSet{
            verticalSlider.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))

        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        verticalSlider.frame = CGRect(x: 200, y: 250, width: 25, height: 400)
        
        label1.text = String(verticalSlider.value)
        
        let minumum = UIImage.init(named: "Line.png")

        /*let image = UIImage.init(named: "apple.png")
        let maximum = UIImage.init(named: "Line 2.png")
        self.verticalSlider.setMinimumTrackImage(minumum, for: .focused)
        self.verticalSlider.setMaximumTrackImage(maximum, for: .normal)
        */
        
        self.verticalSlider.backgroundColor = .systemOrange
        self.verticalSlider.minimumTrackTintColor = .systemOrange
        self.verticalSlider.setMinimumTrackImage(minumum, for: .normal)
        self.verticalSlider.maximumTrackTintColor = .systemGray5
        self.verticalSlider.setValue(Float(Int(1)), animated: true)
        self.verticalSlider.thumbTintColor = .systemOrange
       // self.verticalSlider.setThumbImage(maximum, for: .highlighted)
        
        
    }
    
    @IBAction func SliderChange(_ sender: UISlider)
    {
        //verticalSlider.setValue(Float((Int)((verticalSlider.value + 5) / 1000)), animated:false)
        
        label1.text = String(verticalSlider.value)
        
        if verticalSlider.value == 1.0
        {
            label1.textColor = .black
        }
        
    }
    
}
