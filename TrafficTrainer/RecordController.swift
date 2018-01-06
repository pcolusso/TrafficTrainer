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
    var recording = false
    
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
