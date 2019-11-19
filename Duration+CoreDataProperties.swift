//
//  Duration+CoreDataProperties.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 11/16/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//
//

import Foundation
import CoreData


extension Duration {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Duration> {
        return NSFetchRequest<Duration>(entityName: "Duration")
    }

    @NSManaged public var id: String
    @NSManaged public var timer: Timers?

}
