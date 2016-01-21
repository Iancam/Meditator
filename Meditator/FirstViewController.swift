//
//  FirstViewController.swift
//  Meditator
//
//  Created by Ian Campbell on 1/15/16.
//  Copyright © 2016 Ian Campbell. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

//    MARK: properties
    
    @IBOutlet weak var timeDisplay: UILabel!
    var timer: NSTimer?
    var count: Int = 0
    
    //   MARK: actions
    
    @IBAction func startStopTime(sender: UIButton) {
        timeDisplay.text = "0:00:00"
        if sender.titleForState(.Normal) == "Start"{
            sender.setTitle("Stop", forState: .Normal)
            sender.setTitleColor(UIColor.redColor(), forState: .Normal)
            timer = NSTimer(timeInterval: 1.0, target: self, selector: "countUp", userInfo: nil, repeats: true)
            NSRunLoop.currentRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
            
//            start the timer
        }
        else if sender.titleForState(.Normal) == "Stop"{
            sender.setTitle("Start", forState: .Normal)
            sender.setTitleColor(UIColor.blueColor(), forState: .Normal)
            timer?.invalidate()
            let newSession = MeditationSession(date: NSDate(), duration: count)
            MeditationSession.sessions.append(newSession)
//            MeditationSession.saveData()

            // send new session to the data bank!!
            timeDisplay.text = "0:00:00"
            count = 0
            
//
//            log the resulting time
        }
        
    }
    //MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print(String(segue))
        if let tableViewController = segue.destinationViewController as? MeditationSessionTableViewController {
            tableViewController.tableView.reloadData()
            print("yes, things are workings")
        }
        // Pass the selected object to the new view controller.
    }

    
    // MARK: helper functions
    
    func countUp(){
        count++
        updateTimeLabel()
    }
    
    func updateTimeLabel(){
        let seconds = String(format: "%02d", count%60)
        let minutes = String(format: "%02d", (count/60)%60)
        let hours   = String(format: "%01d", count/(60*60))
        
        timeDisplay.text = "\(hours):\(minutes):\(seconds)"
        
    }

        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    }
}

