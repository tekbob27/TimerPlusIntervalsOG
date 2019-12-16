//
//  Tempus.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 11/29/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//

import Foundation
import Combine

class Tempus: ObservableObject {
    @Published var hh: Int = 0
    @Published var mm: Int = 0
    @Published var ss: Int = 0
    
    var interval: [Int] {
        return [hh, mm, ss]
    }
    
    public func toString() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional // Use the appropriate positioning for the current locale
        formatter.allowedUnits = [ .hour, .minute, .second ] // Units to display in the formatted string
        formatter.zeroFormattingBehavior = [ .pad ] // Pad with zeroes where appropriate for the locale

        return formatter.string(from: Tempus.fromTime(array: interval)) ?? "00:00:00"
    }
    
    public static func fromTime(array: [Int]) -> Double {
        var interval: Double = 0

        for (index, part) in array.reversed().enumerated() {
            interval += Double(part) * pow(Double(60), Double(index))
        }

        return interval
    }
}
