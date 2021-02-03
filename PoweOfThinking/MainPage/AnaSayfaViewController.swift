//
//  AnaSayfaViewController.swift
//  PoweOfThinking
//
//  Created by bora on 7.10.2020.
//

import UIKit
import Firebase
import SwiftUI

class AnaSayfaViewController: UIViewController
{
    var timer: Timer!
    var onlineUsers = ""
    var myclicks : Int = 0
    var rozet : Int = 0
    var totalclick : Int = 0
    var end : Int = 1000000
    
    @IBOutlet weak var BeginButton: UIButton!
    
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var Userinfos: UITextField!
    @IBOutlet weak var OnlineUsers: UILabel!
    @IBOutlet weak var LoveHappies: UILabel!
    @IBOutlet weak var HappyUsers: UILabel!
    @IBOutlet weak var NotBadUsers: UILabel!
    @IBOutlet weak var CryUsers: UILabel!
    @IBOutlet weak var TimeInformation: UILabel!
    
    @IBOutlet weak var NeutralUsers: UILabel!
    
    @IBOutlet weak var ClickNumbers: UILabel!
    
    let userReference = Database.database().reference()
    
    var userNamethree = "Bora Ateş"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // BeginButton.isEnabled = true
            
      //  Userinfos.text = "Bora Ateş" + String(rozet)
        
        if myclicks > 100
        {
            rozet = rozet + 1
            Userinfos.text =  userNamethree + " " + " rozet" + "" + String(rozet)
        }
        else
        {
            rozet = rozet + 2
            Userinfos.text =  userNamethree + " " + " rozet " + "" + String(rozet)
            
        }
        
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateTime), userInfo: nil, repeats: true)
        
        let number = Int.random(in: 6000..<10000)
        OnlineUsers.text = String(number)
        onlineUsers = String(number)
        
        totalclick = Int(onlineUsers)! * 300
       // let clicks = Int.random(in: 0..<100)
        if totalclick > end
        {
            ClickNumbers.text = "1m"
            
        }
        else
        {
        ClickNumbers.text = String(totalclick)
        }
        
        let lovehappies = Int.random(in: 100..<4000)
        LoveHappies.text = String(lovehappies)

        let happies = Int.random(in: 0..<500)
        HappyUsers.text = String(happies)
        
        let neutral = Int.random(in: 0..<100)
        NeutralUsers.text = String(neutral)
        
        let cries = Int.random(in: 0..<500)
        CryUsers.text = String(cries)

        let notbads = Int.random(in: 0..<500)
        NotBadUsers.text = String(notbads)
        
    }
    
    @IBAction func BeginGameClick(_ sender: Any)
    {
        performSegue(withIdentifier: "toGamePage", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "toGamePage"
        {
            let destinationVC = segue.destination as! GamePageViewController
            destinationVC.onlineusers = onlineUsers
            
            
        }
            
    }
    
    @objc func UpdateTime()
    {
        let userCalendar = Calendar.current
           // Set Current Date
        let date = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        // formatter.dateStyle = .long
        let currentDate = Date()
        let newformatter = DateFormatter()
        newformatter.timeStyle = .medium
        let dateTimeString = newformatter.string(from: currentDate)
       
        TimeLabel.text = "Şuan saat : " + "" + dateTimeString
        
        let eventcomponents = userCalendar.dateComponents([.hour,.minute,.second], from: date)
        _ = userCalendar.date(from: eventcomponents)
        
        var eventTimeComponents = DateComponents()
        
        eventTimeComponents.hour = 04
        eventTimeComponents.minute = 35
        eventTimeComponents.second = 00
        eventTimeComponents.timeZone = TimeZone(abbreviation: "GMT+3")
        
        let eventTime = userCalendar.date(from: eventTimeComponents)
       // let eventTimeLeft = userCalendar.dateComponents([.hour, .minute, .second], from: currenttime, to: eventTime)
        let currentime = newformatter.date(from: dateTimeString)
        
       endEvent(eventtime: eventTime!, currenttime: currentime!)
        
           let components = userCalendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: date)
        _ = userCalendar.date(from: components)!
           
        var eventDateComponents = DateComponents()
        
           eventDateComponents.year = 2100
           eventDateComponents.month = 01
           eventDateComponents.day = 00
           eventDateComponents.hour = 17
           eventDateComponents.minute = 01
           eventDateComponents.second = 00
           eventDateComponents.timeZone = TimeZone(abbreviation: "GMT+3")
           
           let eventDate = userCalendar.date(from: eventDateComponents)!
           
           let timeLeft = userCalendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: eventDate)
           
        TimeInformation.text = "PoT " + " " + "\(timeLeft.hour!)h \(timeLeft.minute!)m \(timeLeft.second!)s" + "  " + "sonra başlayacak "
               
    }
    
    func endEvent(eventtime: Date, currenttime: Date)
    {
        if currenttime  == eventtime
        {
            //BeginButton.isEnabled = true
            
         timer.invalidate()
         
        }
        else
        {
           // BeginButton.isEnabled = false
        }
        
    }
       
    
    func makeAlert(titleInput: String, messageInput: String )
    {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
   
}
    
