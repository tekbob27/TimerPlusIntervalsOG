//
//  AbstractInterval+CoreDataProperties.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 11/16/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//
//

import Foundation
import CoreData


extension AbstractInterval {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AbstractInterval> {
        return NSFetchRequest<AbstractInterval>(entityName: "AbstractInterval")
    }

    @NSManaged public var elapsed: Double
    @NSManaged public var duration: Double
    @NSManaged public var sound: String

    public static func fromString(_ span: AbstractInterval, timeString: String) {
        guard !timeString.isEmpty && timeString.contains(":") else {
            span.duration = 0
            return
        }

        let parts = timeString.components(separatedBy: ":")

        span.duration = AbstractInterval.fromTime(timeArray: parts)
    }
        
    public func toString() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional // Use the appropriate positioning for the current locale
        formatter.allowedUnits = [ .hour, .minute, .second ] // Units to display in the formatted string
        formatter.zeroFormattingBehavior = [ .pad ] // Pad with zeroes where appropriate for the locale

        return formatter.string(from: self.duration) ?? "00:00:00"
    }
    
    public var parts: [String] {
        self.toString().components(separatedBy: ":")
    }
    
    public static func fromTime(timeArray: [String]) -> Double {
        var interval: Double = 0

        for (index, part) in timeArray.reversed().enumerated() {
            interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
        }

        return interval
    }
}
