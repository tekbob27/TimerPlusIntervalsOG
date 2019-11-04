//
//  TimerEntity+CoreDataClass.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 8/29/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//
//

import Foundation
import CoreData

@objc(TimerEntity)
public class TimerEntity: NSManagedObject, Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TimerEntity> {
        return NSFetchRequest<TimerEntity>(entityName: "TimerEntity")
    }

    @NSManaged public var alarmSound: String?
    @NSManaged public var alertSound: String?
    @NSManaged public var creationDate: Date?
    @NSManaged public var elapsedTime: Double
    @NSManaged public var id: String?
    @NSManaged public var intervalConsumed: Double
    @NSManaged public var name: String?
    @NSManaged public var order: Int64
    @NSManaged public var duration: DurationEntity?
    @NSManaged public var interval: IntervalEntity?
}

extension TimerEntity {
    public static func newTimerFromInput(_ input: TimerProtocol, context: NSManagedObjectContext) -> TimerEntity {
        let newTimer = TimerEntity(context: context)
        newTimer.name = input.name
        
        DurationEntity.newDurationFromInput(input.duration, context: context).addToTimer(newTimer)
        IntervalEntity.newIntervalFromInput(input.interval, context: context).addToTimer(newTimer)
        
        newTimer.order = input.order + 1
        newTimer.alertSound = input.alertSound
        newTimer.alarmSound = input.alarmSound
        newTimer.id = UUID().uuidString
        return newTimer
    }
}
extension TimerEntity {
    // ❇️ The @FetchRequest property wrapper in the ContentView will call this function
    static func allTimersFetchRequest() -> NSFetchRequest<TimerEntity> {
        let request: NSFetchRequest<TimerEntity> = TimerEntity.fetchRequest()
        
        // ❇️ The @FetchRequest property wrapper in the ContentView requires a sort descriptor
        request.sortDescriptors = [NSSortDescriptor(key: "order", ascending: true)]
          
        return request
    }
}
