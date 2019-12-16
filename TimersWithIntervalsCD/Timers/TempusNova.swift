//
//  TimerSubstitute.swift
//  TimersWithIntervalsCD
//
//  Created by Bob O'Connor on 11/27/19.
//  Copyright © 2019 Bob O'Connor. All rights reserved.
//

import SwiftUI
import Combine

class TempusNova: ObservableObject {
    var id: String = ""
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
        TempusNova.count = 0
    }

    init(count: Int) {
        self.name = "New Timer \(count))"
        TempusNova.count = count
    }
 
    public static func copyTimer(from timer: Timers, to tempus: TempusNova = TempusNova()) -> TempusNova {
        TempusFaci.make(from: timer, copyTo: tempus)
    }
}
