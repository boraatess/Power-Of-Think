//
//  GamePageViewController.swift
//  PoweOfThinking
//
//  Created by bora on 15.10.2020.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore
import SwiftUI

extension UIColor
{
    static func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor
    {
        return UIColor.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }

    static let defaultOuterColor = UIColor.rgb(255, 128, 0)
    static let defaultInnerColor: UIColor = .rgb(76, 0, 153)
    static let defaultPulseFillColor = UIColor.rgb(86, 30, 63)

}

class GamePageViewController: UIViewController
{
    
    var timer : Timer!
    var count = 60
    var onlineusers = ""
    var mycount : Int = 0
    var totalcount :Int = 0
    var cont: CGFloat = 0
    var progressRing: CircularProgressBar!
    
    @IBOutlet weak var myCounts: UILabel!
    @IBOutlet weak var OnlineUsers: UILabel!
    @IBOutlet weak var randomword: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        OnlineUsers.text = String(onlineusers)
        //myCounts.text = String("test")
        
        totalcount = Int(onlineusers)! * 300
        
        /*
         progressBar.labelSize = 60
        progressBar.safePercent = 100
        progressBar.setProgress(to: 1, withAnimation: true)
         */
        
        let xPosition = view.center.x
        let yPosition = view.center.y
        let position = CGPoint(x: xPosition, y: yPosition)
     
        progressRing = CircularProgressBar(radius: 100, position: position, innerTrackColor: .defaultInnerColor, outerTrackColor: .defaultOuterColor, lineWidth: 20)
         view.layer.addSublayer(progressRing)
        
        timer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(incrementCount), userInfo: nil, repeats: true)
         timer.fire()

        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(resetProgressCount)))
    
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(CountLabel), userInfo: nil, repeats: true)
        
        getDataFromFirestore()

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .darkContent
    }
    
    @objc func resetProgressCount() {
        cont = 0
        timer.fire()
    }
    
    @objc func incrementCount() {
        cont += 1
        progressRing.progress = cont
        if count >= Int(100.0) {
            timer.invalidate()
        }
    }
    
    func getDataFromFirestore()
    {
        let firestoreDB = Firestore.firestore()
        
        firestoreDB.collection("Words").addSnapshotListener { (snapshot, error) in
            if error != nil {
                
                print(error?.localizedDescription ?? "error")
            }
            else
            {
                if snapshot?.isEmpty != true && snapshot != nil
                {
                    for document in snapshot!.documents
                    {
                        // let documentid = document.documentID
                        // self.randomword.text = String(documentid)
                        
                        if let dayofword =  document.get("day of word") as? String
                        {
                            self.randomword.text = String(dayofword)
                            
                        }
                        
                    }
                    
                }
                
            }
        }
        
    }
    
    @IBAction func progressChanged(_ sender: UISlider)
    {
      
        //  let progress = CGFloat(sender.value)
        // rotatingProgressBar.progress = progress
        
    }
    
    @objc func CountLabel()
    {
        count -= 1
        //countlabel.text = String(count)
        progressRing.progressLabel.text = String(count)
        
        if count == 0
        {
            timer.invalidate()
            makeAlert(titleInput: "Süre Doldu!", messageInput: "Tıklama sayınız : \(mycount) " + " " + "online kullanıcı sayısı : " + ""  + "\(onlineusers)" + " " + " " + "toplam tıklama :" + "" + "\(totalcount)")
            timer.invalidate()
        
        }
    }
    
    @IBAction func myCountClicked(_ sender: Any)
    {
        mycount = mycount + 1
        myCounts.text = String(mycount)
        
    }

    @IBAction func toBackPage(_ sender: Any)
    {
        self.tabBarController?.selectedIndex = 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "backpage"
        {
            let destinationVC = segue.destination as! AnaSayfaViewController
            destinationVC.myclicks = mycount
            
        }
            
    }
    
    func makeAlert(titleInput: String, messageInput: String )
    {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (UIAlertAction) in
            self.tabBarController?.selectedIndex = 0 // Index to select
                        
        }
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
   

}
