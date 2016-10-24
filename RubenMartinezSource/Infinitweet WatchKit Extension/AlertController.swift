//
//  AlertController.swift
//  Infinitweet
//
//  Created by Ruben on 5/29/15.
//
//

import WatchKit
import Foundation

protocol AlertControllerDelegate {
    func alertControllerDidCompleteDestructively(destructively : Bool)
}

class AlertController: WKInterfaceController {
    @IBOutlet weak var label: WKInterfaceLabel!
    @IBOutlet weak var group: WKInterfaceGroup!
    
    override init() {
        super.init()
        self.setTitle("Close")
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        if context != nil {
            if let text = context!["text"] as? String {
                label.setText(text)
                let positive = context!["positive"] as? Bool
            
                if positive! {
                    //Emerald - rgb(46, 204, 113)
                    group.setBackgroundColor(UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1))
                } else {
                    //Alizarin - rgb(231, 76, 60)
                    group.setBackgroundColor(UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1))
                }
            }
            
            delay(2) {
                let delegate = context!["delegate"] as? AlertControllerDelegate
                let destructively = context!["destructive"] as? Bool
                if delegate != nil && destructively != nil {
                    delegate!.alertControllerDidCompleteDestructively(destructively!)
                }
                
                self.dismissController()
            }
        }
    }
}

func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}