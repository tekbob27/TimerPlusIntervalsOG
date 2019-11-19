//
//  Timers+CoreDataClass.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 11/16/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//
//

import Foundation
import CoreData


public class Timers: NSManagedObject {
    public var dComponents: [ Int64 ] {
        get {
            return self.duration.components
        }
        set {
            self.duration.components = newValue
            try! self.managedObjectContext?.save()
            self.objectWillChange.send()
        }
    }
    
    public var iComponents: [ Int64 ] {
        get {
            return self.interlude.components
        }
        set {
            self.interlude.components = newValue
            try! self.managedObjectContext?.save()
            self.objectWillChange.send()
        }
    }
    
    public var sounds: [ String ] {
        get {
            return [ self.duration.sound, self.interlude.sound ]
        }
        set {
            self.duration.sound = newValue [ 0 ]
            self.interlude.sound = newValue [ 1 ]
            self.objectWillChange.send()
        }
    }
}
