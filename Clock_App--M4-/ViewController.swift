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
    
    // Date format: "EE, dd MMM YYYY hh:mm:ss"
    // e.g. Wed, 28 Dec 2022 14:59:00
    var dateToFormat : DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE, dd MMM YYYY hh:mm:ss"
        return dateFormatter
    }
    
    // Time Remaining format: "hh:mm:ss"
    var timerFormat : DateComponentsFormatter {
        let timerFormatter = DateComponentsFormatter()
        timerFormatter.allowedUnits = [.hour, .minute, .second]
        timerFormatter.zeroFormattingBehavior = .pad
        return timerFormatter
    }
    
    // initialize AM/PM flag, displayMode flag, changeMode flag
    var isAm = true
    var displayMode = true
    var changeMode = false
    
    var clockUpdater = Timer()
    var timerUpdater = Timer()
    var setTimer: Double = 0
    
    
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
        // update Live Clock Display
        let currentDate = Date()
        liveClock.text = dateToFormat.string(from: currentDate)
        
        // update isAm to reflect current AM/PM
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: currentDate)
        //let currentMin = calendar.component(.minute, from: currentDate) // used for testing AM/PM change
        isAm = (currentHour < 12) ? true : false
        
        // changeMode is true when current AM/PM does not match up with Light/Dark mode, respectively
        changeMode = (isAm == displayMode) ? false : true
        
        if (changeMode) { // change displayMode when changeMode is true
            displayMode = !displayMode //toggle displayMode to match current AM/PM flag
            if (displayMode) { // if displayMode is true, activate light mode
                lightMode()
            } else { // if displayMode is false, activate dark mode
                darkMode()
            }
            changeMode = !changeMode // toggle changeMode after displayMode changes are made so it doesnt trigger again until AM/PM flag changes.
        }
        
    }
    
    func lightMode() { // displayMode == true
        bgImage.image = UIImage (named: "am_Image")
        liveClock.textColor = UIColor.black
        timerPicker.overrideUserInterfaceStyle = .light
        startStopButton.titleLabel!.textColor = UIColor.black
        timeRemaining.textColor = UIColor.black
    }
    
    func darkMode() { // displayMode == false
        isAm = false
        bgImage.image = UIImage (named: "pm_Image")
        liveClock.textColor = UIColor.white
        timerPicker.overrideUserInterfaceStyle = .dark
        startStopButton.titleLabel!.textColor = UIColor.white
        timeRemaining.textColor = UIColor.white
    }
    
    @IBAction func startTimer(_ sender: UIButton) {
        timerUpdater.invalidate()
        startStopButton.setTitle("Stop Timer", for: .normal)
        setTimer =  timerPicker.countDownDuration
        timerUpdater = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        setTimer -= 1
        timeRemaining.text = timerFormat.string(from: setTimer)
    }

}

