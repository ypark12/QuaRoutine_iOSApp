//
//  Routine.swift
//  Productivity
//
//  Created by Diego on 6/22/20.
//  Copyright © 2020 Diego. All rights reserved.
//

import UIKit
import os.log

class Routine: NSObject, NSCoding {

    //MARK: Properties

    var name: String
    //var color: String
    var completed: Bool
    var weekdays: [Bool]
    var streak: Int
    //var time: String

    //MARK: Archiving Paths
    // This is for data persistence.  I can handle this part.
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("routine")




    //MARK: Types
    struct PropertyKey {
        static let name = "name"
        //static let color = "color"
        static let completed = "completed"
        static let weekdays = "weekdays"
        static let streak = "streak"
        //static let time = "time"
    }

    //MARK: Initialization

    init(name: String? = nil, /*color: String? = nil,*/ completed: Bool? = nil, weekdays: [Bool]? = nil, streak: Int? = nil /*time: String? = nil*/) {
        //Basic initialization
        self.name = name ?? ""
        //self.color = color ?? ""
        self.completed = completed ?? false
        self.weekdays = weekdays ?? [false, false, false, false, false, false, false]
        self.streak = 0
        //self.time = time ?? "Morning"
    }

    //MARK: NSCoding
    //Also Data persistence, can ignore this section.
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        //aCoder.encode(color, forKey: PropertyKey.color)
        aCoder.encode(completed, forKey: PropertyKey.completed)
        aCoder.encode(weekdays, forKey: PropertyKey.weekdays)
        aCoder.encode(streak, forKey: PropertyKey.streak)
        //aCoder.encode(time, forKey: PropertyKey.time)
    }


    required convenience init?(coder aDecoder: NSCoder) {
        //If the name string cannot be decoded, it should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("unable to decode the name for a Routine object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        
        /* Saving in case we decide to implement later
 
        guard let color = aDecoder.decodeObject(forKey: PropertyKey.color) as? String else {
            os_log("unable to decode the color for a Routine object.", log: OSLog.default, type: .debug)
            return nil
        }
        */
        

        let completed = aDecoder.decodeBool(forKey: PropertyKey.completed)
        
        guard let weekdays = aDecoder.decodeObject(forKey: PropertyKey.weekdays) as? [Bool] else {
            os_log("unable to decode the weekdays for a Routine object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        

        let streak = aDecoder.decodeObject(forKey: PropertyKey.streak) as? Int

        
        /* Will be implemented later
 
        guard let time = aDecoder.decodeObject(forKey: PropertyKey.time) as? String else {
            os_log("unable to decode the time for a Routine object.", log: OSLog.default, type: .debug)
            return nil
        }
        */


        //Call designated init
        self.init(name: name, completed: completed, weekdays: weekdays, streak: streak)
    }

}
