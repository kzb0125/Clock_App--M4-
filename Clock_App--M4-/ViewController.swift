//
//  ViewController.swift
//  Clock_App--M4-
//
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var liveClock: UILabel!
    
    @IBOutlet weak var bgImage: UIImageView!
    
    @IBOutlet weak var timerPicker: UIDatePicker!
    
    @IBOutlet weak var startStopButton: UIButton!
    
    @IBOutlet weak var timeRemaining: UILabel!
    
    
    var dateToFormat : DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE, dd MMM YYYY hh:mm:ss"
        return dateFormatter
    }
    
    var clockUpdater = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // start liveClock Timer
        clockTimer()
    }
    
    // clock Timer
    // configures timer that fires every 1 second
    // when fired, executes updateClock()
    // repeats until invalidated
    func clockTimer() {
        clockUpdater = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateClock), userInfo: nil, repeats: true)
    }
    
    // updates liveClock.text to current time
    // executes every 1 sec, by call from clockTimer
    @objc func updateClock() {
        let currentDate = Date()
        liveClock.text = dateToFormat.string(from: currentDate)
        
        // update bg_image to reflect AM/PM
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: currentDate)
        
        /*
        // AM/PM format testing
            bgImage.image = UIImage (named: "pm_Image")
            liveClock.textColor = UIColor.white
            timerPicker.overrideUserInterfaceStyle = .dark
            startStopButton.titleLabel!.textColor = UIColor.white
            timeRemaining.textColor = UIColor.white
        */
        
        if (currentHour < 12) { // from 0:00 - 11:59 -> AM
             bgImage.image = UIImage (named: "am_Image")
             liveClock.textColor = UIColor.black
             timerPicker.overrideUserInterfaceStyle = .light
             startStopButton.titleLabel!.textColor = UIColor.black
             timeRemaining.textColor = UIColor.black
        } else { // from 12:00 - 23:59 -> PM
             bgImage.image = UIImage (named: "pm_Image")
             liveClock.textColor = UIColor.white
             timerPicker.overrideUserInterfaceStyle = .dark
             startStopButton.titleLabel!.textColor = UIColor.white
             timeRemaining.textColor = UIColor.white
        }
        
    }

}

