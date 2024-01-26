//
//  ViewController.swift
//  Clock_App--M4-
//
//  Created by Ellie Kim on 1/25/24.
//

import UIKit

class ViewController: UIViewController {
    
    var dateFormatter : DateFormatter {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "EE, dd MMM YYYY hh:mm:ss"
        return dateFormat
    }
    
    var timer = Timer()
    
    @IBOutlet weak var liveClock: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //liveClock update
        updateLiveClock()
    }
    
    func updateTimestamp() {
        let dateString  = dateFormatter.string(from: Date())
        
        liveClock.text = "\(dateString)"
        
    }
    
    func updateLiveClock() {
        let clockTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
    }
    
    
    
    
    
}

