//
//  ViewController.swift
//  Clock_App--M4-
//
import UIKit

class ViewController: UIViewController {
    
    var dateToFormat : DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE, dd MMM YYYY hh:mm:ss"
        return dateFormatter
    }
    
    var timer = Timer()
    
    @IBOutlet weak var liveClock: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // start liveClock Timer
        clockTimer()
    }
    
    func updateTimestamp() {
        let dateString  = dateToFormat.string(from: Date())
        
        liveClock.text = "\(dateString)"
        
    }
    
    func clockTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateClock), userInfo: nil, repeats: true)
    }
    
    @objc func updateClock() {
        liveClock.text = dateToFormat.string(from: Date())
    }

}

