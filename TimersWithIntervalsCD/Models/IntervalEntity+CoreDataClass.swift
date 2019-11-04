//
//  IntervalEntity+CoreDataClass.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 8/29/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//
//

import Foundation
import CoreData

@objc(IntervalEntity)
public class IntervalEntity: NSManagedObject, Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IntervalEntity> {
        return NSFetchRequest<IntervalEntity>(entityName: "IntervalEntity")
    }

    @NSManaged public var hours: Int64
    @NSManaged public var minutes: Int64
    @NSManaged public var seconds: Int64
    @NSManaged public var id: String?
    @NSManaged public var timer: NSSet?
}

// MARK: Generated accessors for timer
extension IntervalEntity {

    @objc(addTimerObject:)
    @NSManaged public func addToTimer(_ value: TimerEntity)

    @objc(removeTimerObject:)
    @NSManaged public func removeFromTimer(_ value: TimerEntity)

    @objc(addTimer:)
    @NSManaged public func addToTimer(_ values: NSSet)

    @objc(removeTimer:)
    @NSManaged public func removeFromTimer(_ values: NSSet)

    public static func newIntervalFromInput(_ input: String, context: NSManagedObjectContext) -> IntervalEntity {
        let newInterval = IntervalEntity(context: context)
        let parts = input.components(separatedBy: ":")
        newInterval.hours = Int64(parts[0]) ?? Int64(0)
        newInterval.minutes = Int64(parts[1]) ?? Int64(0)
        newInterval.seconds = Int64(parts[2]) ?? Int64(0)
        newInterval.id = UUID().uuidString
        return newInterval
    }
 
    public func toString() -> String {
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
