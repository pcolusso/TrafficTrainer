//
//  RecordController.swift
//  TrafficTrainer
//
//  Created by Paul Colusso on 6/1/18.
//  Copyright © 2018 Paul Colusso. All rights reserved.
//

import UIKit

class RecordController: UIViewController {
    
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    var recording = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshData()
    }
    
    func refreshData() {
        let date = Date()
        let calendar = Calendar.current
        let weekday  = calendar.component(.weekday, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        let days_of_week = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        
        dayLabel.text = "day: \(days_of_week[weekday - 1])"
        dateLabel.text = "date: \(date.getMonthName()) \(day)"
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        //flip states
        recording = !recording
        sender.backgroundColor = sender.backgroundColor?.inverted
        
        if (recording) {
            sender.setTitle("stop", for: .normal)
            statusLabel.text = "recording now."
        } else {
            sender.setTitle("start", for: .normal)
            statusLabel.text = "done. saved."
        }
    }
}

//taken from https://stackoverflow.com/questions/31639907/with-swift-is-it-possible-to-access-the-invert-colors-function-that-s-in-access
extension UIColor {
    var inverted: UIColor {
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return UIColor(red: (1 - r), green: (1 - g), blue: (1 - b), alpha: a) // Assuming you want the same alpha value.
    }
}


//take from https://stackoverflow.com/questions/43820798/how-can-i-get-current-month-as-string-in-swift
extension Date {
    
    func getMonthName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let strMonth = dateFormatter.string(from: self)
        return strMonth
    }
    
    
}
