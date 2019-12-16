//
//  Tempus.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 11/29/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//

import SwiftUI
import Combine
import CoreData

class Tempus: ObservableObject {

    @Published var hh: Int = 0 {
        willSet {
            self.objectWillChange.send()
        }
    }

    @Published var mm: Int = 0 {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    @Published var ss: Int = 0 {
        willSet {
            self.objectWillChange.send()
        }
    }

    @ObservedObject var interval: ObservableArray<Int> = ObservableArray<Int>(array: []) {
        willSet {
            self.objectWillChange.send()
        }
        didSet {
            self.hh = self.interval.array[0]
            self.mm = self.interval.array[1]
            self.ss = self.interval.array[2]
        }
    }

    init() {
        self.interval = ObservableArray<Int>(array: [self.hh, self.mm, self.ss])
    }

    init(hh: Int, mm: Int, ss: Int) {
        self.hh = hh
        self.mm = mm
        self.ss = ss
        self.interval = ObservableArray<Int>(array: [hh, mm, ss])
    }
    
    public func toString() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional // Use the appropriate positioning for the current locale
        formatter.allowedUnits = [ .hour, .minute, .second ] // Units to display in the formatted string
        formatter.zeroFormattingBehavior = [ .pad ] // Pad with zeroes where appropriate for the locale

        return formatter.string(from: Tempus.fromTime(array: interval.array)) ?? "00:00:00"
    }
    
    private static func fromTime(array: [Int]) -> Double {
        var interval: Double = 0

        for (index, part) in array.reversed().enumerated() {
            interval += Double(part) * pow(Double(60), Double(index))
        }

        return interval
    }
}
