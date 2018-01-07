//
//  RecordController.swift
//  TrafficTrainer
//
//  Created by Paul Colusso on 6/1/18.
//  Copyright © 2018 Paul Colusso. All rights reserved.
//

import UIKit
import CoreLocation

//TODO: need to add permission via info.plist, see https://www.hackingwithswift.com/read/22/2/requesting-location-core-location

class RecordController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    var recording = false
    var timer = NSTimer?
    var locationManager = CLLocationManager!

    let formatter: DateFormatter = {
        let tmpFormatter = DateFormatter()
        tmpFormatter.dateFormat = "hh:mm:ss"
        return tmpFormatter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshData()

        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(self.getTimeOfDate), userInfo: nil, repeats: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }

    func getTimeOfDate() {
        var curDate = Date()

        timeLabel.text = formatter.string(from: curDate)
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

    func submitRecording() {
        //prepare info to send to data layer.
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            //do what we need to do with location.
        }
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
