//
//  Interlude+CoreDataProperties.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 11/16/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//
//

import Foundation
import CoreData


extension Interlude {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Interlude> {
        return NSFetchRequest<Interlude>(entityName: "Interlude")
    }

    @NSManaged public var id: String
    @NSManaged public var timer: Timers

}
