//
//  AbstractInterval+CoreDataClass.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 11/16/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//
//

import Foundation
import CoreData


public class AbstractInterval: NSManagedObject {

    public var components: [ Int64 ] {
        get {
            let a = self.toString().components(separatedBy: ":")
            var i: [Int64] = []
            for str in a {
                i.append(Int64(str) ?? 0)
            }
            return i
        }
        set {
            var interval: Double = 0

            for (index, part) in newValue.reversed().enumerated() {
                interval += Double(part) * pow(Double(60), Double(index))
            }

            self.duration = interval
        }
    }
}
