//
//  ChartViewController.swift
//  Meditator
//
//  Created by Ian Campbell on 3/23/16.
//  Copyright © 2016 Ian Campbell. All rights reserved.
//

//import Foundation
import UIKit
import Charts

class ChartViewController: UIViewController, ChartViewDelegate {
//    MARK: Properties
    @IBOutlet weak var sessionsLineChartView: LineChartView!

//    MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sessionsLineChartView.delegate = self
        self.sessionsLineChartView.descriptionText = "Tap node for details"
        self.sessionsLineChartView.descriptionTextColor = UIColor.whiteColor()
        self.sessionsLineChartView.gridBackgroundColor = UIColor.darkGrayColor()
        self.sessionsLineChartView.noDataText = "no data found"
        
    }
    
    override func viewDidAppear(animated: Bool) {
        setChartData()
    }
    
    func setChartData(){
        let weekdayCount = 7
        let weekdays = ["mon", "tue", "wed","thu","fri","sat","sun"]
        let calendar = NSCalendar.currentCalendar()
        let sessions = MeditationSession.sessions
        // sum durations occuring on the same day, indicate number of sessions on popup
        // if there is a day missed, the graph should show the missed day as empty
        // the graph should show the last 7 days
        // the graph should show weekdays corresponding to the dates in the sessions
        
        let today = NSDate()
        var valAtIndex = [Double](count:weekdayCount, repeatedValue:0.0)
        var xVals: [String] = [String]()
        // all indices are traversed backwards
        for day in 0..<weekdayCount{
            let date = calendar.dateByAddingUnit(.Day, value: -day, toDate: today, options: [.MatchFirst])
            let weekday = calendar.component(.Weekday, fromDate: date!)
            xVals.append(weekdays[weekday-1])
            // get all sessions for day
            for var i=sessions.count-1; i >= 0; i-- {
                let session = sessions[i]
                if calendar.isDate(date!, equalToDate: session.date, toUnitGranularity: .Day){
                    //add a y value at this point
                    valAtIndex[day] += Double(session.duration)
                }
            }
        }
        xVals = xVals.reverse()
        let durations: [Double] = valAtIndex.reverse()
        var YVals: [ChartDataEntry] = [ChartDataEntry]()
        for i in 0..<weekdayCount {
            let entry = ChartDataEntry(value: durations[i], xIndex: i)
            YVals.append(entry)
        }
        let set1 = LineChartDataSet(yVals: YVals, label: "duration")
        set1.axisDependency = .Left
        set1.setColor(UIColor.cyanColor())
        
        var dataSets : [LineChartDataSet] = [LineChartDataSet]()
        dataSets.append(set1)
        
        let data: LineChartData = LineChartData(xVals: xVals, dataSets: dataSets)
        
        sessionsLineChartView.data = data
        
    }
}