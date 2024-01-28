//
//  ViewController.swift
//  Clock_App--M4-
//
import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var liveClock: UILabel!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var timerPicker: UIDatePicker!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var timeRemaining: UILabel!
    
    //test Labels
    
    @IBOutlet weak var isTimerOn: UILabel!
    @IBOutlet weak var isMusicOn: UILabel!
    
    // initialize AM/PM flag, displayMode flag, changeMode flag, timerOn flag
    var isAm = true
    var displayMode = true
    var changeMode = false
    var timerOn = false
    var musicOn = false
    
    var clockUpdater = Timer()
    var timerUpdater = Timer()
    var setTimer: Double = 0
    
    // AVAudioPlayer and audio file location
    var audioPlayer : AVAudioPlayer!
    var amSound = Bundle.main.url(forResource: "am_Sound", withExtension: "mp3")
    var pmSound = Bundle.main.url(forResource: "pm_Sound", withExtension: "mp3")
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // start liveClock Timer
        clockTimer()
        
        //update timerOn and musicOn flags
        updateTestFlags()
    }
    
    // update Test Flags
    func updateTestFlags() {
        isTimerOn.text = "timerOn: \(timerOn)"
        isMusicOn.text = "musicOn: \(musicOn)"
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
                isAm = false
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
        startStopButton.tintColor = UIColor.black
        timeRemaining.textColor = UIColor.black
    }
    
    func darkMode() { // displayMode == false
        bgImage.image = UIImage (named: "pm_Image")
        liveClock.textColor = UIColor.white
        timerPicker.overrideUserInterfaceStyle = .dark
        startStopButton.titleLabel!.textColor = UIColor.white
        startStopButton.tintColor = UIColor.white
        timeRemaining.textColor = UIColor.white
    }
    
    // Timer Button pressed
    // if timerOn == false ? startTimer : stopTimer
    @IBAction func timerPressed(_ sender: UIButton) {
        if (musicOn == false) {
            if (timerOn == false) {
                timerOn = !timerOn
                updateTestFlags()
                startTimer()
            } else {
                timerOn = !timerOn
                updateTestFlags()
                stopTimer()
            }
        } else {
            toggleMusic()
            updateTestFlags()
        }
        
    }
    
    func startTimer() {
        startStopButton.setTitle("Stop Timer", for: .normal)
        setTimer =  timerPicker.countDownDuration
        timerUpdater = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if (setTimer < 1) {
            timerUpdater.invalidate()
            timerOn = false
            updateTestFlags()
            toggleMusic()
        } else {
            updateTestFlags()
            setTimer -= 10 // reset to 1
            var timeAsString = timerFormat.string(from: setTimer)
            timeRemaining.text = "Time Remaining: \(timeAsString ?? "0")"
        }
    }
    
    func toggleMusic() {
        if (musicOn == false) { // if music is NOT ON, play Music
            musicOn = !musicOn
            updateTestFlags()
            startStopButton.setTitle("Stop Music", for: .normal)
            if (isAm) {
                audioPlayer = try! AVAudioPlayer(contentsOf: amSound!)
                audioPlayer.play()
            } else {
                audioPlayer = try! AVAudioPlayer(contentsOf: pmSound!)
                audioPlayer.play()
            }
            
            timeRemaining.text = "Music Playing" // delete
        } else { // if music is ON, stop Music
            musicOn = !musicOn
            updateTestFlags()
            audioPlayer.stop()
            startStopButton.setTitle("Start Timer", for: .normal)
            timeRemaining.text = "Music Stopped" // delete
        }
    }
    
    func stopTimer() {
        timerUpdater.invalidate()
        startStopButton.setTitle("Start Timer", for: .normal)
    }

}

