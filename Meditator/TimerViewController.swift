//
//  TimerViewController.swift
//  Meditator
//
//  Created by Ian Campbell on 1/15/16.
//  Copyright © 2016 Ian Campbell. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

//    MARK: properties
    
    @IBOutlet weak var SessionsTableView: UITableView!
    @IBOutlet weak var timeDisplay: UILabel!
    var timer: NSTimer?
    var count: Int = 0
    
    //   MARK: actions
    @IBAction func startStopTime(sender: UIButton) {
        timeDisplay.text = "0:00:00"
        if sender.titleForState(.Normal) == "Start"{

//            start timer view
            sender.setTitle("Stop", forState: .Normal)
            sender.setTitleColor(UIColor.redColor(), forState: .Normal)

//            start timer
            timer = NSTimer(timeInterval: 1.0, target: self, selector: "countUp", userInfo: nil, repeats: true)
            NSRunLoop.currentRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
            
        }
        else if sender.titleForState(.Normal) == "Stop"{
//            change button color and text
            sender.setTitle("Start", forState: .Normal)
            sender.setTitleColor(UIColor.blueColor(), forState: .Normal)
            
//            log data
            let newSession = MeditationSession(date: NSDate(), duration: count)
            MeditationSession.sessions.append(newSession)
//            show data
            self.SessionsTableView.reloadData()
//            reset time
            timeDisplay.text = "0:00:00"
            timer?.invalidate()
            count = 0
        }
        
    }
    //MARK: Navigation
    
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

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.SessionsTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
//    MARK: UITableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NSLog(String(MeditationSession.sessions.count))
        return MeditationSession.sessions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "MeditationSessionTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MeditationSessionTableViewCell
        print(cell)
        let meditationSession = MeditationSession.sessions[indexPath.row]
        
        cell.SessionDate.text = meditationSession.displayDate
        cell.SessionDuration.text = meditationSession.displayDuration
        return cell
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.SessionsTableView.registerClass(MeditationSessionTableViewCell.self, forCellReuseIdentifier: "MeditationSessionTableViewCell")
    }
}

