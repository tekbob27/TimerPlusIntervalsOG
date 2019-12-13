//
//  TimerSubstitute.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 11/27/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//

import SwiftUI
import Combine
import CoreData

class TimerBrevity: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()

    @Published var duration: Tempus = Tempus() {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    @Published var interlude: Tempus = Tempus() {
        willSet {
            self.objectWillChange.send()
        }
    }

    @Published var sound: Sonus = Sonus() {
        willSet {
            self.objectWillChange.send()
        }
    }

    @Published var name: String = "" {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    public static var count = 0
    
    init() {
        self.name = "New Timer 0"
        TimerBrevity.count = 0
    }

    init(count: Int) {
        self.name = "New Timer \(count))"
        TimerBrevity.count = count
    }
    
    func toString(_ part: String? = nil) -> String {
        switch part {
            case "duration":
                return duration.toString()
            case "interlude":
                return interlude.toString()
            case "alarm":
                return sound.sounds.array.isEmpty || sound.sounds.array.count < 2 ? "" : sound.sounds.array[0]
            case "interrupt":
                return sound.sounds.array.isEmpty || sound.sounds.array.count < 2 ? "" : sound.sounds.array[1]
            default:
                return self.name
        }
    }
}
