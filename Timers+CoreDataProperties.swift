//
//  Timers+CoreDataProperties.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 11/16/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//
//

import Foundation
import CoreData


extension Timers {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Timers> {
        return NSFetchRequest<Timers>(entityName: "Timers")
    }

    @NSManaged public var creationDate: Date
    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var order: Int64
    @NSManaged public var duration: Duration
    @NSManaged public var interlude: Interlude

    public static func allTimersFetchRequest() -> NSFetchRequest<Timers> {
        let request: NSFetchRequest<Timers> = Timers.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(key: "order", ascending: true)]
          
        return request
    }

    public static func timersWithPredicateFetchRequest(predicate: NSPredicate) -> NSFetchRequest<Timers> {
        let request: NSFetchRequest<Timers> = Timers.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(key: "order", ascending: true)]
        request.predicate = predicate
        return request
    }
    
    public func toString() -> String {
        String(format: "%@|%@|%@|%@|%@", self.name, self.duration.toString(), self.interlude.toString(), self.duration.sound, self.interlude.sound)
    }

}
