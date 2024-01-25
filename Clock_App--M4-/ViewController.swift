//
//  ViewController.swift
//  Clock_App--M4-
//
//  Created by Ellie Kim on 1/25/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var liveClock: UILabel!
    // current time
    let currTime = Date()
    
    let dateFormatter = DateFormatter()

    let timeFormat = Date.FormatStyle()
        .weekday(.abbreviated)
        .day(.twoDigits)
        .month(.abbreviated)
        .year(.defaultDigits)
        .hour(.twoDigits(amPM: .omitted))
        .minute(.twoDigits)
        .second(.twoDigits)
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //liveClock update
        updateTimestamp()
    }
    
    func updateTimestamp() {
        dateFormatter.dateFormat = "EE, dd MM YYYY hh:mm:ss"
        let dateString  = dateFormatter.string(from: Date())
        
        liveClock.text = "\(dateString)"
        //liveClock.text = "\(Date().formatted(timeFormat))"
    }
    

    
    
    
}

