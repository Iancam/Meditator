//
//  meditationSession.swift
//  Meditator
//
//  Created by Ian Campbell on 1/17/16.
//  Copyright © 2016 Ian Campbell. All rights reserved.
//

import UIKit

class MeditationSession: NSObject, NSCoding {

    // MARK: properties
    static var sessions = [MeditationSession]()
    var date: NSDate
    var duration: Int = 0
    var displayDate: String {
        get {
            return NSDateFormatter.localizedStringFromDate(self.date, dateStyle: .ShortStyle, timeStyle: .FullStyle)
        }
    }
    
    var displayDuration: String {
        get {
            let seconds = String(format: "%02d", self.duration%60)
            let minutes = String(format: "%02d", (self.duration/60)%60)
            let hours   = String(format: "%01d", self.duration/(60*60))
            return "\(hours):\(minutes):\(seconds)"
        }
    }
    
    // MARK: Types
    
    struct PropertyKey {
        static let durationKey = "duration"
        static let dateKey = "date"
    }
    
    // MARK: Intialization
    
    init(date: NSDate, duration: Int) {
        self.date = date
        self.duration = duration
    }
    
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(date, forKey: PropertyKey.dateKey)
        aCoder.encodeInteger(duration, forKey: PropertyKey.durationKey)
        
    }
    
    
    static func loadData() {
        if let sessions = NSKeyedUnarchiver.unarchiveObjectWithFile(MeditationSession.ArchiveURL.path!) as? [MeditationSession] {
            MeditationSession.sessions += sessions
        }
    }
    
    static func saveData() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(MeditationSession.sessions, toFile: MeditationSession.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save meals...")
        }
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let duration = aDecoder.decodeIntegerForKey(PropertyKey.durationKey)
        let date = aDecoder.decodeObjectForKey(PropertyKey.dateKey) as! NSDate
        self.init(date: date, duration: duration)
    }
    
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("meditationSessions")
}
