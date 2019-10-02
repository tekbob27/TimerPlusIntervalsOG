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

    @NSManaged public var id: String?
    @NSManaged public var hours: Int64
    @NSManaged public var minutes: Int64
    @NSManaged public var seconds: Int64
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

}

 extension IntervalEntity {
     static func newIntervalFromInput(_ input: String, context: NSManagedObjectContext) -> IntervalEntity {
        let newDuration = IntervalEntity(context: context)
        let parts = input.components(separatedBy: ":")
        newDuration.hours = Int64(parts[0]) ?? Int64(0)
        newDuration.minutes = Int64(parts[1]) ?? Int64(0)
        newDuration.seconds = Int64(parts[2]) ?? Int64(0)
        newDuration.id = UUID().uuidString
        return newDuration
     }
 }

extension IntervalEntity {
    func toString() -> String {
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
